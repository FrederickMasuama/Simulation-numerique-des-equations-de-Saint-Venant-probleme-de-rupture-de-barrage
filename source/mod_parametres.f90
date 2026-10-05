MODULE PARAMETRES

  USE iso_fortran_env
  
  IMPLICIT NONE

  INTEGER, PARAMETER :: r8 = REAL64

  !=============================================================
  !parametres maillage
  INTEGER :: Nx
  REAL(r8):: Lx, xmin, xmax, dx, CFL

  !parametres temps
  REAL(r8) :: temps_final, dt

  !parametres vitesses
  REAL (r8) :: a

  !==============================================================

  namelist /maillage/ xmin, xmax, Nx, CFL
  namelist /temps/temps_final
  namelist /vitesse/ a

  !=============================================================

CONTAINS

  SUBROUTINE lire_parametres()
    IMPLICIT NONE

    OPEN(unit=10, file= "parametres.nml", status="old")
    
    READ(10, nml = maillage)
    READ(10, nml = temps)
    READ(10, nml = vitesse)

    CLOSE(10, status="keep")

    Lx = xmax - xmin
    dx = Lx/REAL(Nx,r8)
    dt = CFL * dx/abs(a)

  END SUBROUTINE lire_parametres
  !=================================================================
  
  END MODULE PARAMETRES
