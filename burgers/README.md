# Équation de Burgers 1D — Méthode des volumes finis

## Description

Ce projet étudie numériquement l'**équation de Burgers scalaire 1D** sous sa forme conservative :

$$
\frac{\partial u}{\partial t}
+
\frac{\partial f(u)}{\partial x}
=0,
$$

avec le flux physique

$$
f(u)=\frac{u^2}{2}.
$$

L'équation de Burgers constitue une étape intermédiaire entre l'équation de transport linéaire et les systèmes hyperboliques non linéaires. Elle permet notamment d'étudier la formation de **chocs** et de **raréfactions** à partir de problèmes de Riemann.

La résolution numérique est réalisée par la **méthode des volumes finis**, avec un flux numérique de **Lax-Friedrichs**.

Le projet est développé en **Fortran 90** et automatisé avec **GNU Make**. Les résultats numériques sont visualisés avec **Gnuplot**.

---

## 1. Modèle mathématique

L'équation étudiée est

$$
\boxed{
u_t+\left(\frac{u^2}{2}\right)_x=0
}
$$

où \(u(x,t)\) représente la variable conservative.

Le flux physique est donc

$$ \boxed{f(u)=\frac{u^2}{2}} $$

et la vitesse caractéristique est donnée par

$$ f'(u)=u. $$

Contrairement à l'équation de transport linéaire, la vitesse de propagation dépend ici de la solution elle-même. L'équation est donc **non linéaire**.

---

## 2. Problème de Riemann

Une condition initiale discontinue est utilisée afin d'étudier les structures caractéristiques des équations hyperboliques :

$$ u(x,0)=
\begin{cases}
u_L & \text{si }x<x_0,\\
u_R & \text{si }x\geq x_0.
\end{cases} $$

Deux situations fondamentales peuvent être étudiées.

### Choc

Lorsque

$$ u_L>u_R, $$

les caractéristiques peuvent se rejoindre et conduire à la formation d'un **choc**.

La vitesse du choc est donnée par la condition de Rankine-Hugoniot :

$$ \boxed{ s= \frac{f(u_R)-f(u_L)}{u_R-u_L} } $$

Pour Burgers,

$$ s=\frac{u_L+u_R}{2}. $$

### Raréfaction

Lorsque

$$ u_L<u_R, $$

les caractéristiques s'écartent et une **raréfaction** apparaît.

La solution exacte est alors constituée d'une région intermédiaire dans laquelle

$$ u=\frac{x-x_0}{t}. $$

Cette distinction entre choc et raréfaction constitue un élément essentiel de l'étude numérique des lois de conservation hyperboliques.

---

## 3. Discrétisation par volumes finis

L'équation est intégrée sur une cellule

$$ C_i=[x_{i-\frac12},x_{i+\frac12}]. $$

En notant \(U_i^n\) la moyenne de \(u\) sur la cellule \(i\) au temps \(t^n\), l'intégration de l'équation conduit au schéma conservatif :

$$
\boxed{
U_i^{n+1}
=
U_i^n
-
\frac{\Delta t}{\Delta x}
\left(
F_{i+\frac12}^n
-
F_{i-\frac12}^n
\right)
}
$$

où \(F_{i+\frac12}\) représente le flux numérique à l'interface entre deux cellules.

Cette formulation permet de respecter directement la structure conservative de l'équation.

---

## 4. Flux de Lax-Friedrichs

Le flux numérique utilisé dans ce projet est le flux de Lax-Friedrichs :

$$
\boxed{
F_{i+\frac12}
=
\frac12
\left[
f(U_i)+f(U_{i+1})
\right]
-
\frac{\Delta x}{2\Delta t}
\left(U_{i+1}-U_i\right)
}
$$

avec

$$
f(U)=\frac{U^2}{2}.
$$

Le premier terme correspond à une approximation du flux physique tandis que le second introduit une **dissipation numérique** permettant notamment de stabiliser le calcul en présence de discontinuités.

Cette dissipation entraîne cependant un **lissage des chocs et des raréfactions**, particulièrement visible lorsque le maillage est grossier.

---

## 5. Condition CFL

La vitesse caractéristique de Burgers est

$$ |f'(u)|=|u|. $$

La condition CFL conduit donc à choisir le pas de temps selon

$$
\boxed{
\Delta t
=
CFL\,
\frac{\Delta x}
{\max_i |U_i|}
}
$$

avec

$$ CFL\leq 1. $$

Dans le programme, le pas de temps est recalculé à chaque itération afin de tenir compte de la vitesse maximale présente dans la solution.

Le dernier pas de temps est éventuellement ajusté afin d'atteindre exactement le temps final :

$$
\Delta t_{\text{step}}
=
\min
\left(
\Delta t,\,
t_f-t
\right).
$$

---

## 6. Expérience numérique

Une condition de Riemann est utilisée avec, par exemple,

```text
xmin = -10
xmax = 10
Nx   = 1000
CFL  = 0.9

temps_final = 2

xL = -2
uL = 1
uR = 3
```

Cette configuration correspond à une **raréfaction**, puisque

$$ u_L<u_R. $$

À \(t=2\), la solution exacte est :

$$
u(x,2)=
\begin{cases}
1, & x<-2,\\[2mm]
\dfrac{x+2}{2}, & -2\leq x\leq4,\\[2mm]
3, & x>4.
\end{cases}
$$

La comparaison avec cette solution permet notamment d'observer l'influence de la résolution spatiale et de la dissipation numérique du schéma de Lax-Friedrichs.

---

## 7. Influence de la résolution

La résolution spatiale joue un rôle important dans la qualité de la solution numérique.

Avec un maillage grossier, les transitions sont fortement diffusées par le schéma de Lax-Friedrichs. En augmentant le nombre de cellules, la solution numérique représente plus précisément la structure de la raréfaction ou du choc.

Une étude possible consiste à comparer :

```text
Nx = 100
Nx = 200
Nx = 500
Nx = 1000
```

afin d'observer la convergence de la solution numérique lorsque

$$ \Delta x\rightarrow0. $$

Cette expérience met également en évidence une distinction importante entre **stabilité** et **précision** : respecter la condition CFL garantit la stabilité du schéma, mais ne supprime pas la diffusion numérique introduite par Lax-Friedrichs.

---

## 8. Organisation du projet

```text
burgers/  
|__ source/
│   |__ main.f90
│   |__ mod_parametres.f90
│   |__ mod_initialisations.f90
│   |__ mod_flux.f90
│   |__ mod_solveur.f90
│   |__ mod_sortie.f90
│
|___data/
│   |__ parametres.nml
│   |__ solution_initiale.dat
│
|__ scripts/
│   |__ plot.gnu
│
|__ resultats/
│   |__ condition_initiale.png
│   |__ burgers_finale.png
│
|__ obj/
|__ bin/
|__ Makefile
|__ .gitignore
```

### Rôle des principaux modules

* `mod_parametres.f90` : lecture et gestion des paramètres numériques et physiques.
* `mod_initialisations.f90` : construction du maillage et de la condition initiale de Riemann.
* `mod_flux.f90` : définition du flux physique de Burgers et du flux numérique de Lax-Friedrichs.
* `mod_solveur.f90` : calcul du pas de temps CFL et mise à jour par volumes finis.
* `mod_sortie.f90` : écriture des solutions numériques et des paramètres utilisés.
* `main.f90` : orchestration générale de la simulation.
* `plot.gnu` : génération des graphiques avec Gnuplot.

---

## 9. Compilation et exécution

Depuis le répertoire `burgers/` :

```bash
make
```

La commande compile les modules Fortran, construit l'exécutable puis lance la simulation et génère les graphiques.

Pour supprimer les fichiers de compilation :

```bash
make clean
```

---

## 10. Environnement et outils

* **Fortran 90/2008** — implémentation numérique
* **gfortran** — compilation
* **GNU Make** — automatisation de la compilation et de l'exécution
* **Gnuplot** — visualisation des résultats
* **Git / GitHub** — gestion de versions et archivage du projet

---

## 11. Objectifs numériques

Ce projet permet de mettre en pratique :

* les lois de conservation hyperboliques ;
* la formulation conservative ;
* les problèmes de Riemann ;
* les caractéristiques ;
* la formation des chocs ;
* les raréfactions ;
* la condition de Rankine-Hugoniot ;
* la méthode des volumes finis ;
* les flux numériques ;
* le schéma de Lax-Friedrichs ;
* la condition CFL ;
* la diffusion numérique ;
* l'influence du maillage sur la précision ;
* la convergence numérique.

Il constitue une étape vers l'étude de systèmes hyperboliques non linéaires, notamment les **équations de Saint-Venant**.

---

## 12. Suite du projet

Le projet Burgers constitue la deuxième étape d'une progression consacrée aux méthodes numériques pour les lois de conservation :

$$
\boxed{
\text{Advection linéaire}
\quad\longrightarrow\quad
\text{Burgers}
\quad\longrightarrow\quad
\text{Saint-Venant}
}
$$

L'équation de Burgers permet ainsi de passer d'un problème scalaire linéaire à une loi de conservation scalaire non linéaire, avant d'aborder avec Saint-Venant un **système hyperbolique non linéaire**.

L'objectif est notamment de réutiliser la structure de la méthode des volumes finis et de généraliser le traitement du flux numérique à un système de plusieurs équations.

