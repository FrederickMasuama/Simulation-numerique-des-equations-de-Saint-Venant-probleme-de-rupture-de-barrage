MODULE flux

  USE parametres
  
    IMPLICIT NONE

CONTAINS

  !====================================================================
  
    FUNCTION flux_physique(u) RESULT(f)    

        REAL(r8), INTENT(IN) :: u
        REAL(r8)             :: f

        f = (u * u)/REAL(2,r8)

      END FUNCTION flux_physique
      
    !==================================================================

   FUNCTION flux_lax_friedrichs(uL, uR, dx, dt) RESULT(f)

        REAL(r8), INTENT(IN) :: uL, uR
        REAL(r8), INTENT(IN) :: dx, dt
        REAL(r8)             :: f

        f = 0.5_r8 * (flux_physique(uL) + &
                     flux_physique(uR)) &
            - 0.5_r8 * dx/dt * (uR - uL)

      END FUNCTION flux_lax_friedrichs

      !================================================================

      !FLUX DE GODUNOV
      

END MODULE flux
