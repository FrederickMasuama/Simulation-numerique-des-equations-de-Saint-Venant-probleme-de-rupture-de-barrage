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
   u0(i) = cond_init(x(i))
   
END DO
    
    END SUBROUTINE initialiser


  !==========================================================
  FUNCTION cond_init(x) RESULT(val) ! condition initiale
    implicit none

    REAL(r8), INTENT(IN) :: x
    REAL(r8)             :: val
  
    IF(x < -1.0_r8) THEN
       val = 0.0_r8
    ELSE IF (x >= -1.0_r8 .AND. x <=1.0_r8) THEN
       val = 1.0_r8
    ELSE
       val = 0.0_r8
    END IF
  END FUNCTION cond_init
  !!regarder la vectorisation pour optimier le code!
  !=======================================================
  
  
  END MODULE initialisations
