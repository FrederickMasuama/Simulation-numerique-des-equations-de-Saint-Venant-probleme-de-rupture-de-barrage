# Advection 1D — Méthode des volumes finis

## Description

Ce projet propose une résolution numérique de l'équation d'advection linéaire 1D par la **méthode des volumes finis**, avec un flux numérique de **Lax–Friedrichs**.

L'objectif est d'étudier la propagation d'un profil initial transporté par une vitesse constante, ainsi que l'influence du **nombre de Courant (CFL)** et de la résolution spatiale sur la solution numérique.

Ce projet constitue une première étape vers l'étude de problèmes hyperboliques non linéaires, notamment l'équation de **Burgers** puis les **équations de Saint-Venant**.

---

## 1. Problème étudié

On considère l'équation d'advection :

$$ \frac{\partial u}{\partial t} + a\frac{\partial u}{\partial x} =0, $$

avec une vitesse de propagation constante \(a\).

La solution exacte est simplement le transport du profil initial :

$$ u(x,t)=u_0(x-at). $$

Le problème est donc un modèle simple permettant d'étudier la propagation d'informations sans déformation physique du profil.

---

## 2. Discrétisation par volumes finis

On discrétise le domaine spatial en \(N_x\) cellules de taille

$$ \Delta x=\frac{x_{\max}-x_{\min}}{N_x}. $$

La forme conservative de l'équation est

$$ \frac{\partial u}{\partial t} + \frac{\partial f(u)}{\partial x}=0, $$

avec le flux physique

$$ f(u)=au. $$

La méthode des volumes finis conduit au schéma :

$$ U_i^{n+1} = U_i^n - \frac{\Delta t}{\Delta x} \left(F_{i+1/2}^n-F_{i-1/2}^n \right). $$

---

## 3. Flux de Lax–Friedrichs

Le flux numérique utilisé est le flux de Lax–Friedrichs :

$$
F_{i+1/2}
=
\frac{1}{2}
\left[
f(U_i)+f(U_{i+1})
\right]
-
\frac{\Delta x}{2\Delta t}
\left(U_{i+1}-U_i\right).
$$

Pour l'équation d'advection :

$$
f(U)=aU.
$$

Le second terme du flux introduit une **diffusion numérique**. Celle-ci dépend notamment du rapport entre \(\Delta t\) et \(\Delta x\).

---

## 4. Condition CFL

La stabilité du schéma impose une condition de Courant :

$$
CFL=
\frac{|a|\Delta t}{\Delta x}
\leq 1.
$$

Le pas de temps est choisi selon

$$
\Delta t
=
CFL\frac{\Delta x}{|a|}.
$$

Une expérience particulièrement intéressante est obtenue avec \(CFL=1\). Dans ce cas, pour une vitesse positive, le schéma de Lax–Friedrichs transporte le profil d'une maille par pas de temps et présente une diffusion numérique fortement réduite.

À l'inverse, pour \(CFL<1\), le profil est davantage diffusé.

**Stabilité ne signifie donc pas nécessairement précision.**

---

## 5. Expérience numérique

Une condition initiale en forme de créneau est utilisée pour visualiser facilement le transport :

$$
u(x,0)=
\begin{cases}
1 & \text{si } x\in[-1,1],\\
0 & \text{sinon}.
\end{cases}
$$

Pour une vitesse \(a>0\), le profil se déplace vers la droite avec une vitesse \(a\).

Par exemple, avec :

```text
xmin = -5
xmax = 5
Nx = 100
a = 2
CFL = 1
temps_final = 1
```

le profil initial situé sur \([-1,1]\) doit se retrouver autour de

$$
[1,3]
$$

à \(t=1\).

---

## 6. Influence de la résolution

La précision dépend également de la résolution spatiale.

Avec une résolution trop faible, la diffusion numérique de Lax–Friedrichs devient particulièrement visible. Augmenter \(N_x\) permet de diminuer \(\Delta x\) et de mieux représenter le profil transporté.

Une étude possible consiste à comparer :

```text
Nx = 50
Nx = 100
Nx = 200
Nx = 500
```

afin d'observer la convergence vers la solution exacte.

---

## 7. Organisation du projet

```text
advection1D/
|__source/
│   |__ main.f90
│   |__ mod_parametres.f90
│   |__ mod_initialisations.f90
│   |__ mod_flux.f90
│   |__ mod_solveur.f90
│   |__ mod_sortie.f90
│
|__data/
│   |__ parametres.nml
│   |__ solution.dat
│   |__ solution_initiale.dat
│
|__scripts/
│   |__ plot.gnu
│
|__resultats/
|__ obj/
|__ bin/
|__ Makefile
|__ .gitignore
```

Les modules sont séparés selon leur rôle :

* `mod_parametres.f90` : lecture et gestion des paramètres ;
* `mod_initialisations.f90` : maillage et condition initiale ;
* `mod_flux.f90` : flux physique et flux numérique ;
* `mod_solveur.f90` : schéma volumes finis et évolution temporelle ;
* `mod_sortie.f90` : écriture des résultats ;
* `main.f90` : orchestration de la simulation.

---

## 8. Compilation et exécution

Le projet utilise **Fortran** avec `gfortran`.

Depuis la racine du projet :

```bash
make
```

Le `Makefile` compile le programme, exécute la simulation puis génère les graphiques avec **Gnuplot**.

Pour nettoyer les fichiers de compilation :

```bash
make clean
```

---

## 9. Objectifs pédagogiques

Ce projet permet de mettre en pratique :

* les équations aux dérivées partielles hyperboliques ;
* la forme conservative d'une loi de conservation ;
* la méthode des volumes finis ;
* les flux numériques ;
* le schéma de Lax–Friedrichs ;
* la condition CFL ;
* la diffusion numérique ;
* l'influence de la résolution spatiale ;
* l'organisation modulaire d'un code scientifique en Fortran.

Il constitue également une base pour passer à des problèmes plus complexes :

$$
\boxed{
\text{Advection}
\longrightarrow
\text{Burgers}
\longrightarrow
\text{Saint-Venant}
}
$$

où apparaissent progressivement la non-linéarité, les chocs, les raréfactions et les systèmes hyperboliques.

---

## 10. Environnements et outils utilisés

* **Fortran**
* **gfortran**
* **GNU Make**
* **Gnuplot**
* **Git / GitHub**
* Méthode des **volumes finis**
* Flux de **Lax–Friedrichs**

---

## Licence

Projet réalisé dans le cadre d'un travail académique de fin de **Master 1 MACS — Modélisation, Analyse Numérique et Calcul Scientifique** à Nantes Université.
 
