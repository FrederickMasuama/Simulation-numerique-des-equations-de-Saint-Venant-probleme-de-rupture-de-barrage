MODULE initialisations

  USE iso_fortran_env
  USE parametres

  IMPLICIT NONE

  
  INTEGER                     :: i

CONTAINS
  
  !=========================================================
  SUBROUTINE initialiser(x,U0)
    IMPLICIT NONE

    REAL(r8), INTENT(OUT) :: x(0:Nx), U0(2,0:Nx)

   
    
    DO i = 0, Nx
   !construction du maillage    
       x(i) = xmin + REAL(i, r8) * dx
       !initialisation du vecteur U
       U0(:,i) = cond_init(x(i))
    END DO

    END SUBROUTINE initialiser


  !==========================================================
  FUNCTION cond_init(x) RESULT(U) ! condition initiale
    implicit none

    REAL(r8), INTENT(IN) :: x
    REAL(r8)             :: U(2)
  
    IF(x < x0) THEN !côté gauche
       U(1) = hL
       U(2) = hL*uL
    ELSE
        U(1) = hR  !côté droit
       U(2) = hR*uR
    END IF
    
  END FUNCTION cond_init
  
  !!regarder la vectorisation pour optimier le code!
  !=======================================================
  
  
  END MODULE initialisations
