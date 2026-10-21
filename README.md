# Simulation numérique des lois de conservation en Fortran

Ce projet porte sur l'implémentation et l'étude de méthodes numériques
pour la résolution d'équations aux dérivées partielles (EDP), en particulier
les lois de conservation hyperboliques.

Développé dans le cadre du SSPM (Supervised Study Project in Mathematics): projet de fin de Master 1 MACS 
(Modélisation, Analyse Numérique et Calcul Scientifique) à Nantes Université,
il regroupe trois études numériques complémentaires, allant d'une équation
de transport linéaire à un système non linéaire décrivant les écoulements
à surface libre.

## Objectifs

- Mettre en œuvre des schémas numériques de volumes finis en Fortran ;
- Comprendre le rôle des flux numériques dans la résolution des lois de conservation ;
- Étudier la propagation des ondes et des discontinuités ;
- Comparer les comportements numériques de différents schémas ;
- Développer une organisation modulaire et reproductible du code scientifique.

## Organisation du projet

Le dépôt est organisé en trois parties.

### 1. Advection linéaire — `advection1D/`

Étude numérique de l'équation de transport linéaire :

$$\[
\frac{\partial u}{\partial t}
+a\frac{\partial u}{\partial x}=0.
\]$$

Cette première partie permet d'étudier le transport d'un profil initial
et de comprendre le fonctionnement d'un schéma de volumes finis.

Objectifs :
- Implémenter un schéma de Lax-Friedrichs ;
- Étudier l'influence du pas de temps et du nombre CFL ;
- Observer la diffusion numérique et le déplacement du profil initial.

### 2. Équation de Burgers — `burgers/`

Étude de l'équation de Burgers sous forme conservative :

$$\[
\frac{\partial u}{\partial t}
+\frac{\partial}{\partial x}
\left(\frac{u^2}{2}\right)=0.
\]$$

Cette équation non linéaire permet d'étudier des phénomènes absents
de l'équation de transport linéaire, notamment la formation de chocs
et d'ondes de détente.

Objectifs :
- Étudier une loi de conservation non linéaire ;
- Analyser les solutions de problèmes de Riemann ;
- Étudier le comportement des schémas numériques en présence de discontinuités.

### 3. Équations de Saint-Venant — `saint_venant/`

Étude numérique des équations de Saint-Venant en une dimension d'espace,
appliquées notamment au problème de rupture de barrage.

Le système s'écrit sous forme conservative :

$$\[
\frac{\partial U}{\partial t}
+\frac{\partial F(U)}{\partial x}=0,
\]$$

avec

$$\[
U=
\begin{pmatrix}
h\\
q
\end{pmatrix},
\qquad
F(U)=
\begin{pmatrix}
q\\
\dfrac{q^2}{h}+\dfrac{1}{2}gh^2
\end{pmatrix}.
\]$$

où \(h\) représente la hauteur d'eau, \(q=hu\) le débit par unité
de largeur et \(g\) l'accélération de la pesanteur.

Deux schémas sont implémentés et comparés :
- Lax-Friedrichs classique ;
- MUSCL avec limiteur de pente Minmod et flux de Lax-Friedrichs.

Cette partie permet d'étudier la résolution numérique d'un système
hyperbolique non linéaire et la propagation des ondes dans un écoulement
à surface libre.

## Méthodes numériques

Les méthodes étudiées dans ce projet comprennent :
- la formulation conservative des lois de conservation ;
- la méthode des volumes finis ;
- le calcul de flux numériques ;
- le schéma de Lax-Friedrichs ;
- la reconstruction spatiale MUSCL ;
- le limiteur de pente Minmod ;
- le contrôle du pas de temps par une condition CFL.

## Outils utilisés

- **Fortran 90** — programmation scientifique ;
- **GNU Fortran (`gfortran`)** — compilation ;
- **GNU Make** — automatisation de la compilation ;
- **Gnuplot** — visualisation des résultats ;
- **Git et GitHub** — gestion de versions.

## Organisation générale

```text
.
|__ advection1D/
|__ burgers/
|__ saint_venant/
|__ README.md
|__ Docs
