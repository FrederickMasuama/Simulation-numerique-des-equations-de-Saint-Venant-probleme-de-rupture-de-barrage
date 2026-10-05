MODULE solveur

  USE parametres
  USE flux, only : flux_lax_friedrichs

  IMPLICIT NONE
  

CONTAINS
  
  !=====================================================================
  
  SUBROUTINE  solveur_lax_friedrichs(u, un, dt_step)

    IMPLICIT NONE

    REAL(r8), INTENT(IN)  :: u(0:Nx)
    REAL(r8), INTENT(OUT) :: un(0:Nx)
    REAL(r8), INTENT(IN)  :: dt_step
    REAL(r8)              :: flux_gauche
    REAL(r8)              :: flux_droite
    INTEGER               :: i

   
  
  
    DO i = 1, Nx-1

       !calcule des flux
       flux_gauche = flux_lax_friedrichs(u(i-1), u(i), dx, dt_step)
       flux_droite = flux_lax_friedrichs(u(i), u(i+1), dx, dt_step)
       !mise à jour conservative
       un(i) = u(i) - dt_step/dx * (flux_droite - flux_gauche)

    END DO
    
    ! Conditions aux limites    
   un(0)  = u(0)
   un(Nx) = u(Nx)
  
  END SUBROUTINE solveur_lax_friedrichs 

  !=================================================================
  SUBROUTINE calcul_dt(u, dt)

    IMPLICIT NONE

    REAL(r8), INTENT(IN)  :: u(0:Nx)
    REAL(r8), INTENT(OUT) :: dt
    REAL(r8) :: umax

    umax = MAXVAL(ABS(u))

    IF (umax > 0.0_r8) THEN
       dt = CFL * dx / umax
    ELSE
       dt = temps_final
    END IF

  END SUBROUTINE calcul_dt
  
  !================================================================
  END MODULE solveur
