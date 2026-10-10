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

  !parametres physiques
  REAL (r8) :: x0, g, uL, uR, hL, hR

  !==============================================================

  namelist /maillage/ xmin, xmax, Nx, CFL
  namelist /temps/temps_final
  namelist /physiques/ x0, g, uL, uR, hL, hR

  !=============================================================

CONTAINS

  SUBROUTINE lire_parametres()
    IMPLICIT NONE

    OPEN(unit=10, file= "parametres.nml", status="old", ACTION ="READ")
    
    READ(10, nml = maillage)
    READ(10, nml = temps)
    READ(10, nml = physiques)

    CLOSE(10, status="keep")

    Lx = xmax - xmin
    dx = Lx/REAL(Nx,r8)

    ! Verification elementaire des parametres
    IF (Nx < 2) THEN
       ERROR STOP "Erreur : Nx doit etre au moins egal a 2."
    END IF

    IF (xmax <= xmin) THEN
       ERROR STOP "Erreur : xmax doit etre superieur a xmin."
    END IF

    IF (CFL <= 0.0_r8 .OR. CFL > 1.0_r8) THEN
       ERROR STOP "Erreur : choisir un CFL dans ]0,1]."
    END IF

    IF (temps_final <= 0.0_r8) THEN
       ERROR STOP "Erreur : temps_final doit etre positif."
    END IF

    IF (g <= 0.0_r8) THEN
       ERROR STOP "Erreur : g doit etre positif."
    END IF

    IF (hL <= 0.0_r8 .OR. hR <= 0.0_r8) THEN
       ERROR STOP "Erreur : les hauteurs initiales doivent etre positives."
    END IF

  END SUBROUTINE lire_parametres
  !=================================================================
  
  END MODULE PARAMETRES
