MODULE sortie

  USE iso_fortran_env
  USE parametres

  IMPLICIT NONE

CONTAINS

  !==========================================================
  SUBROUTINE ecrire_parametres()

  IMPLICIT NONE

  OPEN(unit=40, file="../data/parametres_plot.dat", &
       status="replace", action="write")

  WRITE(6,*) "uL", uL
  WRITE(6,*) "uR", uR
  WRITE(6,*) "xL", xL
  WRITE(6,*) "xR", xR

  CLOSE(40)

END SUBROUTINE ecrire_parametres
  
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

  SUBROUTINE ecrire_solution_initiale(x, u0)

  IMPLICIT NONE

  REAL(r8), INTENT(IN) :: x(0:Nx)
  REAL(r8), INTENT(IN) :: u0(0:Nx)

  INTEGER :: i

  OPEN(unit=30, file="../data/solution_initiale.dat", status="replace")

  DO i = 0, Nx
     WRITE(30,*) x(i), u0(i)
  END DO

  CLOSE(30)

END SUBROUTINE ecrire_solution_initiale
  !=============================================================
END MODULE sortie
