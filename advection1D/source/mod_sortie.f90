MODULE sortie

  USE iso_fortran_env
  USE parametres

  IMPLICIT NONE

CONTAINS

  !=============================================================
  
  SUBROUTINE ecrire_solution(x, u)

    IMPLICIT NONE

    REAL(r8), INTENT(IN) :: x(0:Nx)
    REAL(r8), INTENT(IN) :: u(0:Nx)
    INTEGER :: i


    OPEN(unit=20, file="solution.dat", status="replace", &
         action="write")

    DO i = 0, Nx
       WRITE(20,*) x(i), u(i)
    END DO

    CLOSE(20)

  END SUBROUTINE ecrire_solution

  !=============================================================

END MODULE sortie
