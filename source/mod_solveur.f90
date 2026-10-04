MODULE solveur

  USE parametres
  USE initialisations
  USE flux, only : flux_lax_friedrichs

  IMPLICIT NONE
  

CONTAINS
  
  !=====================================================================
  
  SUBROUTINE  solveur_lax_friedrichs(u, un, Nx, dx, dt, a)

    IMPLICIT NONE

    INTEGER, INTENT(IN)   :: Nx
    REAL(r8), INTENT(IN)  :: dx
    REAL(r8), INTENT(IN)  :: dt
    REAL(r8), INTENT(IN)  :: a
    REAL(r8), INTENT(IN)  :: u(0:Nx)
    REAL(r8), INTENT(OUT) :: un(0:Nx)
    REAL(r8)              :: flux_gauche
    REAL(r8)              :: flux_droite
    INTEGER               :: i

    DO i = 1, Nx-1
       
       flux_gauche = flux_lax_friedrichs(u(i-1), u(i), a, dx, dt)
       flux_droite = flux_lax_friedrichs(u(i), u(i+1), a, dx, dt)
       un(i) = u(i) - dt/dx * (flux_droite - flux_gauche)

    END DO

  END SUBROUTINE solveur_lax_friedrichs 

  !=================================================================
  
  END MODULE solveur
