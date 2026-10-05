MODULE initialisations

  USE iso_fortran_env
  USE parametres

  IMPLICIT NONE

  
  INTEGER                     :: i

CONTAINS
  
  !=========================================================
  SUBROUTINE initialiser(x,u0)
    IMPLICIT NONE

    REAL(r8), INTENT(OUT) :: x(0:Nx), u0(0:Nx)

   
    
    DO i = 0, Nx
       
   x(i) = xmin + REAL(i, r8) * dx
   u0(i) = cond_init(x(i), uR, uL)
   
END DO

    END SUBROUTINE initialiser


  !==========================================================
  FUNCTION cond_init(x, uR, uL) RESULT(val) ! condition initiale
    implicit none

    REAL(r8), INTENT(IN) :: x, uR, uL
    REAL(r8)             :: val
  
    IF(x < xL) THEN
       val = uL
    ELSE
       val = uR
    END IF
  END FUNCTION cond_init
  !!regarder la vectorisation pour optimier le code!
  !=======================================================
  
  
  END MODULE initialisations
