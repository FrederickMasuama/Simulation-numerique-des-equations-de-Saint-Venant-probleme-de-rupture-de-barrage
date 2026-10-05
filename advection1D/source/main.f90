PROGRAM advection

  USE parametres
  USE initialisations
  USE flux
  USE solveur
  USE sortie

  
  IMPLICIT NONE
  
  REAL(r8), ALLOCATABLE :: x(:)
  REAL(r8), ALLOCATABLE :: u(:)
  REAL(r8), ALLOCATABLE :: un(:)
  !INTEGER                :: Nx
  REAL(r8)               :: t, dt_step

  !===============!
  !initialisations!
  !===============!
  CALL lire_parametres()
  
  ALLOCATE(x(0:Nx))
  ALLOCATE(u(0:Nx))
  ALLOCATE(un(0:Nx))

  CALL initialiser(x,u)

  !==============!
  !boucleen temps!
  !==============!

   t = 0.0_r8

    DO WHILE (t < temps_final)

        ! Dernier pas éventuellement plus petit
        dt_step = MIN(dt, temps_final - t)

        CALL solveur_lax_friedrichs(u, un, dt_step)

        ! Passage de U^(n+1) à U^n
        u = un

        ! Avancement du temps
        t = t + dt_step

     END DO

     CALL ecrire_solution(x, u)
  END PROGRAM advection 
