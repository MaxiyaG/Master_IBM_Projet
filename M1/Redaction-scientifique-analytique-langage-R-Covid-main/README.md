
## Introduction
Ce projet d'analyse statistique porte sur l'évolution de la pandémie de Covid-19 dans les pays de l'Union Européenne en 2020. Les données proviennent d'un recensement mondial de la Covid-19 effectué par le Centre européen pour le contrôle et la prévention des maladies (ECDC). L'objectif est d'analyser les nombres de cas et de décès, de déterminer les pays les plus touchés, d'effectuer des tests statistiques et de visualiser l'évolution temporelle. Le projet à étais réalisé à 2 dans le cadre de la 1er années Master Bio-Informatique

## Méthodologie
L'analyse quantitative rétrospective couvre la période du 01/01/2020 au 14/12/2020 pour les 27 pays de l'Union Européenne. Les outils utilisés sont le langage R et RStudio, avec des techniques de statistiques descriptives et analytiques.

## Résultats
Statistiques descriptives
Le projet débute par le chargement des données, la réduction aux pays de l'UE, puis l'agrégation des cas et des décès par mois. Des statistiques descriptives, telles que la moyenne et l'écart-type, sont présentées pour l'ensemble de l'UE et pour la France.

## Évolution mensuelle
Des graphiques illustrent l'évolution mensuelle du nombre de cas et de décès pour les cinq pays les plus touchés : France, Allemagne, Italie, Espagne et Pologne.

## Similarité des ratios
Une analyse de variance (ANOVA) est utilisée pour déterminer la similarité des ratios de décès sur cas entre les pays de l'UE. Le test de Kruskal-Wallis est appliqué en raison de la non-normalité des données.

## Tests de Corrélation
Des tests de corrélation entre le nombre de cas et de décès, ainsi qu'entre le nombre de cas et la population, sont effectués.

## Discussion
La France enregistre le plus grand nombre de cas, tandis que des disparités entre pays peuvent s'expliquer par des facteurs comme la taille de la population et le tourisme. L'analyse temporelle révèle des moments critiques, tels qu'une augmentation en avril liée à la contagiosité initiale du virus et une deuxième vague à partir de septembre.

## Conclusion
La pandémie de Covid-19 a eu un impact significatif en Europe, soulignant l'importance des mesures préventives. Les résultats de cette analyse offrent une compréhension approfondie de l'évolution de la pandémie en 2020, soulignant la nécessité continue de surveillance et d'intervention.

## Exécution du Code
- Intaller le répository github.
- Installez R : R https://cran.rstudio.com
- Installez RStudio : https://posit.co/download/rstudio-desktop/
- Téléchargez le code R et les données du projet.
- Exécutez le code dans RStudio, assurez-vous d'avoir installé 

les bibliothèques nécessaires (ggplot2, ggpubr, knitr, prettyR).

N'hésité pas a consulté le PDF.