##  Équations de Saint-Venant — Problème de rupture de barrage

### Présentation

Cette partie du projet porte sur la résolution numérique des équations de Saint-Venant en une dimension d'espace, qui décrivent les écoulements à surface libre en eau peu profonde.

L'objectif est d'étudier la propagation des ondes et des discontinuités à travers un problème de rupture de barrage, en mettant en œuvre et en comparant deux schémas numériques de volumes finis :
- le schéma de Lax-Friedrichs classique ;
- le schéma MUSCL avec limiteur de pente Minmod et flux de Lax-Friedrichs.

### Modèle mathématique

Les équations de Saint-Venant sont écrites sous forme conservative :

\[
\frac{\partial U}{\partial t}
+\frac{\partial F(U)}{\partial x}=0,
\]

avec

\[
U=
\begin{pmatrix}
h\\
q
\end{pmatrix},
\qquad q=hu,
\]

et

\[
F(U)=
\begin{pmatrix}
q\\
\dfrac{q^2}{h}+\dfrac{1}{2}gh^2
\end{pmatrix}.
\]

où :
- \(h\) désigne la hauteur d'eau ;
- \(u\) est la vitesse moyenne de l'écoulement ;
- \(q=hu\) est le débit par unité de largeur ;
- \(g\) est l'accélération de la pesanteur.

Le modèle considéré ne comporte pas de termes sources.

### Méthodes numériques

**1. Schéma de Lax-Friedrichs**

Un schéma de volumes finis est utilisé pour discrétiser les équations de conservation. Le flux numérique de Lax-Friedrichs s'écrit :

\[
F_{i+\frac12}
=
\frac{F(U_i)+F(U_{i+1})}{2}
-\frac{\Delta x}{2\Delta t}(U_{i+1}-U_i).
\]

Ce schéma permet d'étudier la propagation des ondes, mais introduit une diffusion numérique qui peut lisser les discontinuités.

**2. Schéma MUSCL-Minmod**

Le schéma MUSCL améliore la reconstruction spatiale en utilisant une approximation linéaire par cellule. Les pentes sont calculées à l'aide du limiteur Minmod, qui réduit les pentes au voisinage des discontinuités afin de limiter les oscillations numériques.

Les flux aux interfaces sont ensuite calculés à partir des états reconstruits, en conservant le flux numérique de Lax-Friedrichs.

La reconstruction vise un ordre 2 en espace dans les zones régulières. La mise à jour temporelle reste toutefois explicite et d'ordre 1.

### Gestion du pas de temps

Le pas de temps est adapté à l'aide d'une condition CFL, fondée sur la vitesse maximale de propagation des ondes :

\[
\Delta t
=
\mathrm{CFL}\,
\frac{\Delta x}
{\displaystyle\max_i\left(|u_i|+\sqrt{gh_i}\right)}.
\]

Cette adaptation permet de tenir compte de l'évolution des vitesses caractéristiques au cours de la simulation.

### Implémentation

Le programme est développé en Fortran 90 et organisé en modules :
- gestion des paramètres physiques et numériques ;
- calcul des flux physiques et numériques ;
- initialisation des conditions ;
- résolution par Lax-Friedrichs ;
- résolution par MUSCL-Minmod ;
- écriture des résultats et génération des données d'animation.

Les paramètres de simulation sont définis dans un fichier `parametres.nml`.

### Résultats et perspectives

Les simulations permettent de comparer les profils de hauteur d'eau obtenus avec les deux schémas et d'étudier leur comportement lors de la propagation des discontinuités.

Les perspectives de développement comprennent :
- une étude quantitative de convergence en fonction du maillage ;
- la vérification de la conservation de la masse ;
- la comparaison avec des solutions de référence ;
- l'étude de la diffusion numérique et de la précision des schémas.

### Outils utilisés

- Fortran 90 — implémentation numérique ;
- GNU Fortran (`gfortran`) — compilation ;
- GNU Make — automatisation de la compilation ;
- Gnuplot — visualisation des résultats ;
- Git et GitHub — gestion de versions.
