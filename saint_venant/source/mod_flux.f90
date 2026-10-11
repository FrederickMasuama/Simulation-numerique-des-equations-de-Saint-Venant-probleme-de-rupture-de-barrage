MODULE flux

  USE parametres
  
    IMPLICIT NONE

CONTAINS

  !====================================================================
  
    FUNCTION flux_physique(U) RESULT(F)    

        REAL(r8), INTENT(IN) :: U(2)
        REAL(r8)             :: F(2)
        REAL(r8)             :: h, q

        h = U(1)
        q = U(2)

        F(1) = q
        F(2) = q*q/h + 0.5_r8 * g * h * h

      END FUNCTION flux_physique
      
    !==================================================================

   FUNCTION flux_lax_friedrichs(uL, uR, dx, dt) RESULT(F)

        REAL(r8), INTENT(IN) :: UL(2), UR(2)
        REAL(r8), INTENT(IN) :: dx, dt
        REAL(r8)             :: F(2)
        !REAL(r8)             :: FL(2), FR(2)

        F = 0.5_r8 * (flux_physique(UL) + &
                     flux_physique(UR)) &
            - 0.5_r8 * dx/dt * (UR - UL)

      END FUNCTION flux_lax_friedrichs

      !================================================================

      !FLUX DE GODUNOV
      

END MODULE flux
