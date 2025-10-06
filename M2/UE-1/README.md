# 🧬 Projet UE1 - Analyse de la prise en charge de la tuberculose en France (2023)

## 📘 Description du projet
Ce projet, réalisé dans le cadre du **Master 2 Santé Publique – Parcours Informatique Biomédicale**, a pour objectif d’analyser les **différences dans la prise en charge de la tuberculose pulmonaire** selon :
- les **régions de France métropolitaine**,  
- et les **types administratifs d’établissements de santé** (publics, privés, PSPH).

L’étude repose sur les données hospitalières issues de la plateforme **ScanSanté (ATIH)**, en se concentrant sur l’année **2023**.

---

## 🎯 Objectifs
1. Identifier les **différences de pratiques diagnostiques et thérapeutiques** entre les établissements publics et privés.  
2. Évaluer les **disparités régionales** dans la durée moyenne de séjour (DMS) et les ressources mobilisées.  
3. Étudier l’influence des **régimes de financement** (DG, PSPH, OQN) sur la gestion des cas de tuberculose.  
4. Examiner l’impact des **comorbidités et actes médicaux** sur la DMS et les coûts hospitaliers.

---

## 🧪 Méthodologie

### 🔹 Sources de données
- **ScanSanté** : statistiques hospitalières fournies par l’ATIH.  
- **Hetop** : portail ontologique pour la validation des codes diagnostics.  
- **Terminologies utilisées** :
  - CIM-10 : code **A15** (tuberculose pulmonaire),
  - SNOMED,
  - MeSH.  

### 🔹 Outils & concepts
- **UMLS (CUI : C0041296)** pour la standardisation des concepts médicaux.  
- Étude centrée sur le **GHM 04M19** (« Tuberculoses ») et le sous-groupe **04M192** (niveau de sévérité 2).  
- Extraction des données **MCO** pour l’année **2023**.

### 🔹 Méthodes d’analyse
- Sélection par **diagnostic principal (DP)**, **diagnostics associés (DAS)** et **actes CCAM**.  
- Étude comparative :
  - **Public vs Privé** : analyse des actes, diagnostics associés, niveaux de sévérité.
  - **Interrégionale** : Grand Est, Pays de la Loire, Provence-Alpes-Côte d’Azur (PACA).

---

## 📊 Résultats principaux

### 🧠 Diagnostics fréquents (GHM 04M19)
| Diagnostic | Code CIM-10 | Fréquence (%) | DMS (jours) |
|-------------|--------------|----------------|---------------|
| Tuberculose pulmonaire confirmée par examen microscopique | A150 | 36,4 | 18,9 |
| Tuberculose pulmonaire non précisée | A162 | 14,3 | - |
| Tuberculose pulmonaire atypique | A151 | 7,4 | 18,9 |

### 🩺 Actes médicaux les plus fréquents
| Acte | Code CCAM | Fréquence (%) | DMS (jours) |
|------|------------|---------------|--------------|
| Fibrobronchoscopie + lavage broncho-alvéolaire | GEQE004 | 31,7 | 19,1 |
| Fibrobronchoscopie seule | GEQE007 | 21,9 | 21,9 |

### ⏱️ Actes associés aux plus longues DMS
- GCQE001 : Fibro-pharyngoscopie et laryngoscopie nasale → **41,5 j**  
- GEQE009 : Fibro-bronchoscopie avec lavage (intubés/trachéotomisés) → **37,2 j**  
- HEQE002 : Endoscopie oeso-gastro-duodénale → **35,4 j**

### ⚖️ Comparaison Public / Privé
| Indicateur | Secteur Public | Secteur Privé |
|-------------|----------------|----------------|
| DMS moyenne | plus longue | plus courte |
| Diagnostics associés | 5,85 | 4,26 |
| Actes totaux | 4,02 | 4,83 |
| Actes classants | 0,36 | 0,56 |

> 🔹 **Public (DG/PSPH)** : approche plus globale et intégrative.  
> 🔹 **Privé (OQN)** : plus d’actes, gestion plus réactive.

### 🌍 Disparités régionales (GHM 04M192)
| Région | DMS (jours) | Médiane | Âge moyen (ans) |
|--------|--------------|----------|-----------------|
| Grand Est | 15,88 | 13 | 37,95 |
| Pays de la Loire | 12,33 | 10 | 38,05 |
| PACA | 13,83 | 11 | 38,48 |
| Moyenne nationale | 14,08 | 11 | 36,93 |

---

## 💬 Discussion
- **Influence des actes lourds** (ex. fibrobronchoscopie) sur la DMS.  
- **Complémentarité Public/Privé** :  
  - Public → approche globale, comorbidités.  
  - Privé → réactivité, productivité.  
- **Disparités régionales** liées aux :
  - Protocoles de soins,
  - Ressources hospitalières (lits, personnels),
  - Facteurs socio-économiques,
  - Organisation locale (ex. CLAT du Grand Est).

---

## 🧩 Conclusion
L’étude montre que :
- Les **établissements publics et privés** présentent des **approches complémentaires** dans la prise en charge de la tuberculose.  
- Des **disparités régionales** persistent malgré une épidémiologie similaire.  
- Les outils **Hetop** et **ScanSanté** jouent un rôle clé dans la **standardisation**, **interopérabilité** et **analyse des données hospitalières**.  

> 🧭 Ces résultats appuient l’importance d’une coordination intersectorielle et régionale pour une prise en charge plus homogène des cas de tuberculose.

---

## 🧱 Références
1. Kherabi, Y. et al. *Patient-centered approach to the management of drug-resistant tuberculosis in France* – PLOS Global Public Health, 2022.  
2. [ScanSanté - Coûts hospitaliers (ATIH)](https://www.scansante.fr/applications/enc-mco?origin=serp_auto)  
3. [Ministère de la Santé - Feuille de route Tuberculose (2019)](https://sante.gouv.fr/IMG/pdf/feuille_de_route_tuberculose_2019.pdf)  
4. [Recensement des CLAT (2020)](https://splf.fr/wp-content/uploads/2020/03/CLAT-2020-06-22.pdf)  
5. Pradipta, I.S. et al. *Barriers and strategies to successful tuberculosis treatment* – BMC Public Health, 2021.  
6. [FHF - Éléments tarifaires 2023](https://www.fhf.fr/sites/default/files/2023-10/dae_20230331_0004_0001_0.pdf)

