MODULE sortie

  USE parametres

  IMPLICIT NONE

CONTAINS

  !==========================================================
  SUBROUTINE ecrire_parametres()

  IMPLICIT NONE

  OPEN(unit=40, file="../data/parametres_plot.dat", &
       status="replace", action="write")

  WRITE(40,*) "# Parametres de la simulation Saint-Venant"
  WRITE(40,*) "# xmin, xmax, Nx, dx"
  WRITE(40,*) xmin, xmax, Nx, dx
  WRITE(40,*) "# CFL, temps_final"
  WRITE(40,*) CFL, temps_final
  WRITE(40,*) "# g, x0"
  WRITE(40,*) g, x0
  WRITE(40,*) "# hL, hR, uL, uR"
  WRITE(40,*) hL, hR, uL, uR

  CLOSE(40)

END SUBROUTINE ecrire_parametres
  
  !=============================================================
  
  SUBROUTINE ecrire_solution(x, U)

    IMPLICIT NONE

    REAL(r8), INTENT(IN) :: x(0:Nx)
    REAL(r8), INTENT(IN) :: U(2,0:Nx)
    INTEGER :: i
    REAL(r8):: h, q, vitesse


    OPEN(unit=20, file="solution.dat", status="replace", &
         action="write")

    WRITE(20,*) "# x, h, q, vitesse"

    DO i = 0, Nx
       
       h = U(1,i)
       q = U(2,i)

       IF (h > 0.0_r8) THEN
          vitesse = q/h
       ELSE
          vitesse = 0.0_r8
       END IF

       WRITE(20,*) x(i), h, q, vitesse

    END DO

    CLOSE(20)

  END SUBROUTINE ecrire_solution

  !=============================================================

  SUBROUTINE ecrire_solution_initiale(x, u0)

  IMPLICIT NONE

  REAL(r8), INTENT(IN) :: x(0:Nx)
  REAL(r8), INTENT(IN) :: U0(2,0:Nx)
  INTEGER :: i
  REAL(r8) :: h, q, vitesse

  OPEN(unit=30, file="../data/solution_initiale.dat", status="replace", ACTION="WRITE")

  WRITE(30,*) "# x, h, q, vitesse"

    DO i = 0, Nx

       h = U0(1,i)
       q = U0(2,i)

       IF (h > 0.0_r8) THEN
          vitesse = q/h
       ELSE
          vitesse = 0.0_r8
       END IF

       WRITE(30,*) x(i), h, q, vitesse
  END DO

  CLOSE(30)

END SUBROUTINE ecrire_solution_initiale
!=============================================================
  ! Ecriture d'une image intermediaire de la simulation


  SUBROUTINE ecrire_frame(k, x, U)

    IMPLICIT NONE

    INTEGER, INTENT(IN) :: k
    REAL(r8), INTENT(IN) :: x(0:Nx)
    REAL(r8), INTENT(IN) :: U(2,0:Nx)

    INTEGER :: i
    CHARACTER(LEN=64) :: simulation

    WRITE(simulation,'("frame_",I5.5,".dat")') k

    OPEN(UNIT=50, FILE=TRIM(simulation), &
         STATUS="REPLACE", ACTION="WRITE")

    DO i = 0, Nx
       WRITE(50,*) x(i), U(1,i)
    END DO

    CLOSE(50)

  END SUBROUTINE ecrire_frame
!=============================================================
END MODULE sortie
