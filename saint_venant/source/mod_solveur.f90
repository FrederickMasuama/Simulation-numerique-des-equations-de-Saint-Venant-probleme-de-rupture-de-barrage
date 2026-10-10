MODULE solveur

  USE parametres
  USE flux, only : flux_lax_friedrichs

  IMPLICIT NONE
  

CONTAINS
  
  !=====================================================================
  
  SUBROUTINE  solveur_lax_friedrichs(u, un, dt_step)

    IMPLICIT NONE

    REAL(r8), INTENT(IN)  :: U(2,0:Nx)
    REAL(r8), INTENT(OUT) :: Un(2,0:Nx)
    REAL(r8), INTENT(IN)  :: dt_step
    REAL(r8)              :: flux_gauche(2)
    REAL(r8)              :: flux_droite(2)
    INTEGER               :: i

   
  
  
    DO i = 1, Nx-1

       !calcule des flux
       flux_gauche = flux_lax_friedrichs(U(:,i-1), U(:,i), dx, dt_step)
       flux_droite = flux_lax_friedrichs(U(:,i), U(:,i+1), dx, dt_step)
       !mise à jour conservative à 2 variables
       Un(:,i) = U(:,i) - dt_step/dx * (flux_droite - flux_gauche)

    END DO
    
    ! Conditions aux limites    
   Un(:,0)  = U(:,0)
   Un(:,Nx) = U(:,Nx)
  
  END SUBROUTINE solveur_lax_friedrichs 

  !=================================================================
  SUBROUTINE calcul_dt(u, dt)

    IMPLICIT NONE

    REAL(r8), INTENT(IN)  :: U(2,0:Nx)
    REAL(r8), INTENT(OUT) :: dt
    REAL(r8) :: vitesse_max, vitesse, h, q
    INTEGER               :: i

    vitesse_max = 0.0_r8

    DO i = 0, Nx
       h = U(1,i)
       q = U(2,i)

       ! la hateur d'eau doit être strictement positive pour éviter la division par zéro
       IF(h <= 0.0_r8) THEN
          ERROR STOP "Erreur : hauteur d'eau nulle ou négative."
       END IF

       !vitesse moyenne de l'eau
       vitesse = q/h

       !vitessse maximale de propagation d'onde
       vitesse_max = Max(vitesse_max, ABS(vitesse) + SQRT(g*h))

    END DO

    IF (vitesse_max > 0.0_r8) THEN
       dt = CFL * dx / vitesse_max
    ELSE
       dt = temps_final
    END IF


  END SUBROUTINE calcul_dt
  
  !================================================================
  END MODULE solveur
