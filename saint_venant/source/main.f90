PROGRAM saint_venant

  USE parametres
  USE initialisations, ONLY : initialiser
  USE solveur
  USE solveur_muscl
  USE sortie

  IMPLICIT NONE

  REAL(r8), ALLOCATABLE :: x(:)
  REAL(r8), ALLOCATABLE :: U(:,:)
  REAL(r8), ALLOCATABLE :: Un(:,:)
  REAL(r8), ALLOCATABLE :: U_LF(:,:)

  REAL(r8) :: t, dt_step

  INTEGER :: frame, i

  !==================================!
  ! INITIALISATIONS GENERALES        !
  !==================================!

  CALL lire_parametres()

  ALLOCATE(x(0:Nx))
  ALLOCATE(U(2,0:Nx))
  ALLOCATE(Un(2,0:Nx))
  ALLOCATE(U_LF(2,0:Nx))

  CALL initialiser(x, U)

  ! Sauvegarde de la solution initiale
  CALL ecrire_solution_initiale(x, U)


  !====================================!
  ! SCHEMA 1 : LAX-FRIEDRICHS CLASSIQUE!
  !====================================!

  PRINT *, "=========================================="
  PRINT *, "Simulation 1 : Lax-Friedrichs classique"
  PRINT *, "=========================================="

  t = 0.0_r8
  frame = 0

  ! Enregistrement de l'etat initial
  CALL ecrire_frame(frame, x, U, "LF")

  DO WHILE (t < temps_final)

     ! Calcul du pas de temps respectant la CFL
     CALL calcul_dt(U, dt)

     ! Adaptation du dernier pas de temps
     dt_step = MIN(dt, temps_final - t)

     ! Resolution numerique
     CALL solveur_lax_friedrichs(U, Un, dt_step)

     ! Passage au temps suivant
     U = Un

     ! Avancement du temps
     t = t + dt_step

     ! Enregistrement d'une image pour le GIF LF
     frame = frame + 1
     CALL ecrire_frame(frame, x, U, "LF")

  END DO

  ! Conservation de la solution finale LF
  U_LF = U

  PRINT *, "Lax-Friedrichs termine."
  PRINT *, "Temps final atteint : ", t
  PRINT *, "Nombre de pas de temps : ", frame

  ! Sauvegarde du nombre d'images du GIF LF
  OPEN(UNIT=70, FILE="nb_frames_LF.dat", &
       STATUS="REPLACE", ACTION="WRITE")

  WRITE(70,*) frame

  CLOSE(70)

  ! Sauvegarde de la solution finale LF
  CALL ecrire_solution(x, U_LF)


  !==================================!
  ! REINITIALISATION DE LA SOLUTION  !
  !==================================!

  PRINT *, " "
  PRINT *, "Reinitialisation de la solution..."

  CALL initialiser(x, U)

  t = 0.0_r8
  frame = 0

  ! Enregistrement de l'etat initial MUSCL
  CALL ecrire_frame(frame, x, U, "MUSCL")


  !=========================================!
  ! SCHEMA 2 : MUSCL-MINMOD + LAX-FRIEDRICHS!
  !=========================================!

  PRINT *, "=========================================="
  PRINT *, "Simulation 2 : MUSCL-Minmod-Lax-Friedrichs"
  PRINT *, "=========================================="

  DO WHILE (t < temps_final)

     ! Calcul du pas de temps respectant la CFL
     CALL calcul_dt(U, dt)

     ! Adaptation du dernier pas de temps
     dt_step = MIN(dt, temps_final - t)

     ! Resolution numerique MUSCL
     CALL solveur_muscl_lax_friedrichs(U, Un, dt_step)

     ! Passage au temps suivant
     U = Un

     ! Avancement du temps
     t = t + dt_step

     ! Enregistrement d'une image pour le GIF MUSCL
     frame = frame + 1
     CALL ecrire_frame(frame, x, U, "MUSCL")

  END DO

  PRINT *, "MUSCL termine."
  PRINT *, "Temps final atteint : ", t
  PRINT *, "Nombre de pas de temps : ", frame

  ! Sauvegarde du nombre d'images du GIF MUSCL
  OPEN(UNIT=73, FILE="nb_frames_MUSCL.dat", &
       STATUS="REPLACE", ACTION="WRITE")

  WRITE(73,*) frame

  CLOSE(73)


  !==================================!
  ! ENREGISTREMENT DES COMPARAISONS  !
  !==================================!

  ! comparaison.dat :
  ! colonne 1 : position x
  ! colonne 2 : hauteur d'eau LF
  ! colonne 3 : hauteur d'eau MUSCL

  OPEN(UNIT=71, FILE="comparaison.dat", &
       STATUS="REPLACE", ACTION="WRITE")

  DO i = 0, Nx

     WRITE(71,*) x(i), U_LF(1,i), U(1,i)

  END DO

  CLOSE(71)


  ! Sauvegarde de la solution finale MUSCL
  ! solution_muscl.dat :
  ! colonne 1 : position x
  ! colonne 2 : hauteur d'eau h
  ! colonne 3 : debit q

  OPEN(UNIT=72, FILE="solution_muscl.dat", &
       STATUS="REPLACE", ACTION="WRITE")

  DO i = 0, Nx

     WRITE(72,*) x(i), U(1,i), U(2,i)

  END DO

  CLOSE(72)


  !==================================!
  ! FIN DU PROGRAMME                 !
  !==================================!

  CALL ecrire_parametres()

  DEALLOCATE(x, U, Un, U_LF)

  PRINT *, " "
  PRINT *, "=========================================="
  PRINT *, "Les deux simulations sont terminees."
  PRINT *, "Fichier comparatif : comparaison.dat"
  PRINT *, "Solution MUSCL : solution_muscl.dat"
  PRINT *, "Images GIF LF : frame_LF_*.dat"
  PRINT *, "Images GIF MUSCL : frame_MUSCL_*.dat"
  PRINT *, "=========================================="

END PROGRAM saint_venant
