MODULE convergence

  USE parametres
  USE initialisations, ONLY : initialiser
  USE solveur, ONLY : calcul_dt
  USE solveur_muscl, ONLY : solveur_muscl_lax_friedrichs

  IMPLICIT NONE

CONTAINS

  SUBROUTINE etude_convergence_muscl()

    IMPLICIT NONE

    INTEGER, PARAMETER :: nb_maillages = 5
    INTEGER, PARAMETER :: maillages(nb_maillages) = &
         [50, 100, 200, 400, 800]

    INTEGER :: k, i, n
    INTEGER :: unite

    REAL(r8) :: t, dt_step
    REAL(r8) :: poids

    REAL(r8) :: erreur_h(nb_maillages-1)
    REAL(r8) :: erreur_q(nb_maillages-1)

    REAL(r8) :: ordre_h, ordre_q

    REAL(r8), ALLOCATABLE :: x(:)
    REAL(r8), ALLOCATABLE :: U(:,:)
    REAL(r8), ALLOCATABLE :: Un(:,:)

    ! Stockage des solutions sur tous les maillages.
    REAL(r8), ALLOCATABLE :: solutions(:,:,:)

    !=========================================================
    ! Lecture des paramètres physiques et temporels
    !=========================================================

    CALL lire_parametres()

    ! Le maillage le plus fin comporte 800 intervalles.
    ALLOCATE(solutions(2,0:maillages(nb_maillages),nb_maillages))

    PRINT *, " "
    PRINT *, "=========================================="
    PRINT *, " ETUDE DE CONVERGENCE MUSCL"
    PRINT *, "=========================================="

    !=========================================================
    ! 1. Calcul des solutions pour chaque maillage
    !=========================================================

    DO k = 1, nb_maillages

       n = maillages(k)

       PRINT *, " "
       PRINT *, "Simulation avec Nx = ", n

       ! Adaptation des paramètres au nouveau maillage.
       Nx = n
       dx = Lx / REAL(Nx,r8)

       ALLOCATE(x(0:Nx))
       ALLOCATE(U(2,0:Nx))
       ALLOCATE(Un(2,0:Nx))

       ! Initialisation de la solution.
       CALL initialiser(x,U)

       t = 0.0_r8

       ! Résolution jusqu'au temps final.
       DO WHILE (t < temps_final)

          CALL calcul_dt(U,dt)

          dt_step = MIN(dt,temps_final-t)

          CALL solveur_muscl_lax_friedrichs(U,Un,dt_step)

          U = Un

          t = t + dt_step

       END DO

       ! Sauvegarde en mémoire de la solution finale.
       solutions(:,0:Nx,k) = U

       PRINT *, "Temps final atteint : ", t

       DEALLOCATE(x,U,Un)

    END DO

    !=========================================================
    ! 2. Comparaison des solutions successives
    !=========================================================

    DO k = 1, nb_maillages-1

       n = maillages(k)

       erreur_h(k) = 0.0_r8
       erreur_q(k) = 0.0_r8

       ! Les grilles étant emboîtées, le point i du maillage
       ! grossier correspond au point 2*i du maillage suivant.

       DO i = 0, n

          poids = 1.0_r8

          ! Pondération trapézoïdale aux extrémités.
          IF (i == 0 .OR. i == n) poids = 0.5_r8

          erreur_h(k) = erreur_h(k) + poids * ABS( &
               solutions(1,i,k) - solutions(1,2*i,k+1))

          erreur_q(k) = erreur_q(k) + poids * ABS( &
               solutions(2,i,k) - solutions(2,2*i,k+1))

       END DO

       ! Approximation des normes L1 des différences.
       erreur_h(k) = erreur_h(k) * &
            (Lx / REAL(n,r8))

       erreur_q(k) = erreur_q(k) * &
            (Lx / REAL(n,r8))

    END DO

    !=========================================================
    ! 3. Enregistrement des différences
    !=========================================================

    OPEN(NEWUNIT=unite, FILE="convergence_muscl.dat", &
         STATUS="REPLACE", ACTION="WRITE")

    WRITE(unite,'(A)') "# Nx  Difference_h  Difference_q"

    DO k = 1, nb_maillages-1

       WRITE(unite,'(I6,2ES16.7)') &
            maillages(k), erreur_h(k), erreur_q(k)

    END DO

    CLOSE(unite)

    !=========================================================
    ! 4. Calcul des ordres observés
    !=========================================================

    PRINT *, " "
    PRINT *, "Differences entre maillages successifs"
    PRINT *, "------------------------------------------"
    PRINT *, "   Nx       Difference h      Difference q"

    DO k = 1, nb_maillages-1

       WRITE(*,'(I6,2ES20.8)') &
            maillages(k), erreur_h(k), erreur_q(k)

    END DO

    PRINT *, " "
    PRINT *, "Ordres de convergence observes"
    PRINT *, "------------------------------------------"
    PRINT *, "   Nx       Ordre h           Ordre q"

    DO k = 1, nb_maillages-2

       ! On évite le logarithme d'une erreur nulle.
       IF (erreur_h(k) > 0.0_r8 .AND. &
           erreur_h(k+1) > 0.0_r8) THEN

          ordre_h = LOG(erreur_h(k)/erreur_h(k+1)) / LOG(2.0_r8)

       ELSE

          ordre_h = 0.0_r8

       END IF

       IF (erreur_q(k) > 0.0_r8 .AND. &
           erreur_q(k+1) > 0.0_r8) THEN

          ordre_q = LOG(erreur_q(k)/erreur_q(k+1)) / LOG(2.0_r8)

       ELSE

          ordre_q = 0.0_r8

       END IF

       WRITE(*,'(I6,2F18.6)') maillages(k), ordre_h, ordre_q

    END DO

    DEALLOCATE(solutions)

    PRINT *, " "
    PRINT *, "Resultats ecrits dans convergence_muscl.dat"

  END SUBROUTINE etude_convergence_muscl

END MODULE convergence
