# Calcul d’IMC de patients diabétiques et non diabétiques

Ce mini projet vise à calculer l’indice de masse corporelle (IMC) de patients diabétiques et non diabétiques.
Le projet a été réalisé dans le cadre d’un cours à l’université Sorbonne Paris-Nord, sous la supervision de Mme Julie Marin, professeur de langage R.

# Prérequis
Pour exécuter ce projet sur Windows, Linux, ou MacOS, vous aurez besoin de :

- installer le langage R
- Intaller l'environnement RStudio
- Le package rmarkdown (install.packages("rmarkdown"))
- Le package tinytex (tinytex::install_tinytex())

installer R et Rstudio : [ici](https://posit.co/download/rstudio-desktop/)


# Installation

- Clonez ce dépôt sur votre machine locale.
- Ouvrez le fichier Rmd dans RStudio.

# Utilisation
Le fichier Rmd contient plusieurs sections :

- Chargement des données : Cette section charge les données à partir d’un fichier CSV nommé “imc.csv”.

- Calcul de l’IMC : Cette section définit une fonction pour calculer l’IMC et l’applique à chaque patient dans le jeu de données.

- Corrélation entre le poids et la taille : Cette section calcule et affiche le coefficient de corrélation entre le poids et la taille des patients.

- Graphique de la relation entre le poids et la taille : Cette section crée un graphique montrant la relation entre le poids et la taille pour chaque groupe de patients.

- Histogrammes de l’IMC : Cette section crée des histogrammes montrant la distribution de l’IMC pour chaque groupe de patients.

- Différence d’IMC entre les groupes : Cette section teste si la différence d’IMC entre les groupes est significative.

- Pour exécuter le code, vous pouvez simplement ouvrir le fichier Rmd dans RStudio et cliquer sur le bouton “Knit”. Cela générera un document PDF avec les résultats.