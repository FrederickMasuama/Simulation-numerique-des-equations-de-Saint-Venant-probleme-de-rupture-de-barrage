MODULE initialisations

  USE iso_fortran_env
  USE parametres

  IMPLICIT NONE

  CALL lire_parametres()

  !=========================================================
  !initialisations matrices
  REAL(r8), ALLOCATABLE, SAVE :: x(:), u0(:), un(:)
  INTEGER                     :: i

  ALLOCATE(x(0:Nx), u(0:Nx),un(0:Nx))

  x = xmin + [(REAL(i - 1, r8) *dx, i = 1, Nx)]
  !=========================================================

CONTAINS

  !==========================================================
  fucntion u0(x) ! condition initiale
  implicit none

  REAL (r8) :: u0
  REAL(r8), INTENT(IN) :: x

  u = 0.0d0
  
  IF(x < -1) THEN
     u0(x) = 0
  ELSE IF (x >= -1 & x <=1) THEN
     u0(x) = 1
  ELSE
     u0(x) = 0
  END IF

  !!regarder la vectorisation pour optimier le code!
  !=======================================================
  
  
  END MODULE initialisations
