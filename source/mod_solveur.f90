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

    ! Conditions aux limites
  !un(0)  = 0.0_r8
  !un(Nx) = 0.0_r8
  
    DO i = 1, Nx-1

       !calcule des flux
       flux_gauche = flux_lax_friedrichs(u(i-1), u(i), a, dx, dt_step)
       flux_droite = flux_lax_friedrichs(u(i), u(i+1), a, dx, dt_step)
       !mise à jour conservative
       un(i) = u(i) - dt_step/dx * (flux_droite - flux_gauche)

    END DO

!!$   DO i = 1, Nx-1
!!$
!!$     un(i) = 0.5_r8 * (u(i+1) + u(i-1)) &
!!$             - 0.5_r8 * a * dt_step/dx * &
!!$             (u(i+1) - u(i-1))
!!$  end do

   un(0)  = u(0)
  un(Nx) = u(Nx)
  
  END SUBROUTINE solveur_lax_friedrichs 

  !=================================================================
  
  END MODULE solveur
