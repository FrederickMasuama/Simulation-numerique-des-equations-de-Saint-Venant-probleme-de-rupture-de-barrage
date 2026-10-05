MODULE flux

  USE parametres
  
    IMPLICIT NONE

CONTAINS

  !====================================================================
  
    FUNCTION flux_physique(u, a) RESULT(f)     !le cas d'advection

        REAL(r8), INTENT(IN) :: u
        REAL(r8), INTENT(in) :: a
        REAL(r8)             :: f

        f = a * u

      END FUNCTION flux_physique
      
    !==================================================================

   FUNCTION flux_lax_friedrichs(uL, uR, a, dx, dt) RESULT(f)

        REAL(r8), INTENT(IN) :: uL, uR
        REAL(r8), INTENT(IN) :: a, dx, dt
        REAL(r8)             :: f

        f = 0.5_r8 * (flux_physique(uL, a) + &
                     flux_physique(uR, a)) &
            - 0.5_r8 * dx/dt * (uR - uL)

      END FUNCTION flux_lax_friedrichs

      !================================================================

      !FLUX DE GODUNOV
      

END MODULE flux
