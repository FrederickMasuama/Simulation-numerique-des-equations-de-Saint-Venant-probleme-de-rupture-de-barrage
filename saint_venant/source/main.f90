PROGRAM saint_venant

  USE parametres
  USE initialisations
  USE solveur
  USE sortie

  
  IMPLICIT NONE
  
  REAL(r8), ALLOCATABLE :: x(:)
  REAL(r8), ALLOCATABLE :: U(:,:)
  REAL(r8), ALLOCATABLE :: Un(:,:)
  REAL(r8)              :: t, dt_step
  INTEGER               :: frame

  !===============!
  !initialisations!
  !===============!
  CALL lire_parametres()
  
  ALLOCATE(x(0:Nx))
  ALLOCATE(U(2,0:Nx))
  ALLOCATE(Un(2,0:Nx))

  CALL initialiser(x,U)
  CALL ecrire_solution_initiale(x, U)

  frame = 0
  CALL ecrire_frame(frame, x, U)
  
  !==============!
  !boucleen temps!
  !==============!

   t = 0.0_r8

    DO WHILE (t < temps_final)

       CALL calcul_dt(U, dt)
       
        ! Dernier pas éventuellement plus petit
        dt_step = MIN(dt, temps_final - t)

        CALL solveur_lax_friedrichs(U, Un, dt_step)

        ! Passage de U^(n+1) à U^n
        U = Un

        ! Avancement du temps
        t = t + dt_step

         ! Enregistrement d'une nouvelle image
        frame = frame + 1
        CALL ecrire_frame(frame, x, U)
   
     END DO

     OPEN(UNIT=70, FILE="nb_frames.dat", STATUS="REPLACE", ACTION="WRITE")

     WRITE(70,*) frame

     CLOSE(70)

     !=========!
     !affichage!
     !=========!
     CALL ecrire_solution(x, U)
     CALL ecrire_parametres()

     DEALLOCATE(x, U, Un)

     
  END PROGRAM saint_venant 
