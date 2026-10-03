MODULE initialisations

  USE iso_fortran_env
  USE parametres

  IMPLICIT NONE

  REAL(r8), ALLOCATABLE, SAVE :: x(:), u0(:), un(:)
  INTEGER                     :: i

CONTAINS
  
  !=========================================================
  SUBROUTINE initialiser()
    IMPLICIT NONE

    CALL lire_parametres()
    
    ALLOCATE(x(0:Nx), u0(0:Nx),un(0:Nx))

    x = xmin + [(REAL(i - 1, r8) *dx, i = 1, Nx)]   !discrétisation

    DO i = 0, Nx
       u0(i) = cond_init(x(i))                      !solution_initiale
    END DO

    un = u0
    
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
