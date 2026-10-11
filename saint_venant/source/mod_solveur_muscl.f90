MODULE solveur_muscl

  USE parametres
  USE flux, ONLY : flux_lax_friedrichs

  IMPLICIT NONE

CONTAINS

  !==========================
  ! Limiteur de pente Minmod
  !==========================

  FUNCTION minmod(a, b) RESULT(s)

    REAL(r8), INTENT(IN) :: a, b
    REAL(r8)             :: s

    IF (a > 0.0_r8 .AND. b > 0.0_r8) THEN

       s = MIN(a, b)

    ELSE IF (a < 0.0_r8 .AND. b < 0.0_r8) THEN

       s = MAX(a, b)

    ELSE

       s = 0.0_r8

    END IF

  END FUNCTION minmod


  !===========================================================
  ! Solveur MUSCL avec flux de Lax-Friedrichs
  !===========================================================

  SUBROUTINE solveur_muscl_lax_friedrichs(U, Un, dt_step)

    IMPLICIT NONE

    REAL(r8), INTENT(IN)  :: U(2,0:Nx)
    REAL(r8), INTENT(OUT) :: Un(2,0:Nx)
    REAL(r8), INTENT(IN)  :: dt_step

    REAL(r8) :: pente(2,0:Nx)
    REAL(r8) :: UL(2), UR(2)
    REAL(r8) :: flux_gauche(2), flux_droite(2)

    INTEGER :: i, k


    ! 1. Calcul des pentes limitées
    pente = 0.0_r8

    DO i = 1, Nx-1

       DO k = 1, 2

          pente(k,i) = minmod( &
               (U(k,i)   - U(k,i-1))/dx, &
               (U(k,i+1) - U(k,i))/dx  )

       END DO

    END DO


    
    ! 2. Mise à jour conservative
    DO i = 1, Nx-1

       ! Flux à l'interface gauche : i - 1/2
       UL = U(:,i-1) + 0.5_r8*dx*pente(:,i-1)

       UR = U(:,i)   - 0.5_r8*dx*pente(:,i)

       flux_gauche = flux_lax_friedrichs( &
                         UL, UR, dx, dt_step)


       ! Flux à l'interface droite : i + 1/2
       UL = U(:,i)   + 0.5_r8*dx*pente(:,i)

       UR = U(:,i+1) - 0.5_r8*dx*pente(:,i+1)

       flux_droite = flux_lax_friedrichs( &
                         UL, UR, dx, dt_step)


       ! Mise à jour de la solution
       Un(:,i) = U(:,i) - (dt_step/dx) &
                   *(flux_droite - flux_gauche)

    END DO


    
    ! 3. Conditions aux limites
    Un(:,0)  = U(:,0)
    Un(:,Nx) = U(:,Nx)

  END SUBROUTINE solveur_muscl_lax_friedrichs

END MODULE solveur_muscl
