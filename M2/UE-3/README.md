# 🏥 Entrepôt de données OMOP – Étude de l'hypertension artérielle (HTA)

> Projet UE-3 · Master 2 Informatique Biomédicale · 2024-2025

Conception d'un entrepôt de données standardisé (**OMOP CDM v5.4**) à partir de la base **MIMIC-III Clinical Database Demo (v1.4)**, dans le but d'identifier les médicaments les plus prescrits chez des patients souffrant probablement d'hypertension artérielle (HTA).

---

## 📋 Contexte

L'hypertension artérielle touche, selon l'OMS, 1,28 milliard de personnes dans le monde en 2023, dont 46 % l'ignorent¹. Cette maladie chronique endommage progressivement les parois vasculaires et favorise des complications graves : AVC, infarctus du myocarde, insuffisance cardiaque.

Dans les bases de données cliniques centrées sur des patients gravement malades comme MIMIC-III, l'HTA est rarement un diagnostic principal — elle est sous-représentée au profit des pathologies aiguës. Aucun patient de la base n'est donc hospitalisé *pour* une HTA. L'identification des traitements anti-hypertenseurs passe alors par une **approche indirecte** : repérer les patients hospitalisés pour des pathologies dont l'HTA est un facteur de risque connu, puis observer les médicaments qui leur sont prescrits.

**Objectif du projet :** construire un mini entrepôt de données interopérable, au format OMOP, permettant d'identifier les médicaments les plus prescrits chez ces patients.

---

## 🗂️ Données sources

Les données proviennent de **MIMIC-III Clinical Database Demo v1.4**. Cinq tables sources ont été sélectionnées et réduites aux colonnes d'intérêt :

| Fichier source | Description |
|---|---|
| `PATIENTS.csv` | Informations démographiques des patients |
| `ADMISSIONS.csv` | Hospitalisations et diagnostics associés |
| `DIAGNOSES_ICD.csv` | Diagnostics codés en ICD-9 |
| `PRESCRIPTIONS.csv` | Prescriptions médicamenteuses |
| `CHARTEVENTS.csv` | Mesures cliniques (dont la pression artérielle) |

### Critères de sélection des patients

Aucun patient n'étant hospitalisé pour une HTA à proprement parler, les patients ont été sélectionnés à partir de trois pathologies pour lesquelles l'HTA constitue un facteur de risque majeur :

- **STROKE/TIA** — Accident vasculaire cérébral (AVC)
- **INFERIOR MYOCARDIAL INFARCTION\CATH** — Infarctus inférieur du myocarde
- **CONGESTIVE HEART FAILURE** — Insuffisance cardiaque congestive

Patients retenus : `10026`, `10088`, `10111`, `10124`, `42075`, `43870`

### Médicaments anti-hypertenseurs ciblés

`Metoprolol`, `Metoprolol XL`, `Lisinopril`, `Hydralazine` / `Hydralazine HCl`, `Captopril`, `Atenolol`, `Losartan Potassium`, `Diltiazem`, `Spironolactone`, `Labetalol`

---

## 🔄 Méthodologie

### 1. Sélection et réduction des colonnes
Chaque table source a été chargée dans R (dataframes), puis réduite aux seules colonnes pertinentes pour l'entrepôt.

### 2. Mapping des tables vers le format OMOP CDM v5.4
Le mapping des noms de tables et de colonnes a été réalisé avec les logiciels **WhiteRabbit** et **Rabbit in a Hat**, permettant de passer du schéma MIMIC-III au schéma standardisé OMOP.

| Table source (MIMIC-III) | Table cible (OMOP CDM v5.4) |
|---|---|
| `patients.csv` | `PERSON` |
| `admissions.csv` | `VISIT_OCCURRENCE` |
| `diagnoses_icd.csv` | `CONDITION_OCCURRENCE` |
| `prescriptions.csv` | `DRUG_EXPOSURE` |
| `chartevents.csv` | `MEASUREMENT` |

#### Détail du mapping des colonnes

**PERSON**
| Source | OMOP |
|---|---|
| `subject_id` | `person_id` |
| `gender` | `gender_concept_id` |
| `dob` | `year_of_birth` |

**VISIT_OCCURRENCE**
| Source | OMOP |
|---|---|
| `subject_id` | `person_id` |
| `hadm_id` | `visit_occurrence_id` |
| `admittime` | `visit_start_datetime` |
| `dischtime` | `visit_end_datetime` |
| `diagnosis` | `visit_source_value` |

**CONDITION_OCCURRENCE**
| Source | OMOP |
|---|---|
| `subject_id` | `person_id` |
| `hadm_id` | `visit_occurrence_id` |
| `icd9_code` | `condition_source_value` |

**DRUG_EXPOSURE**
| Source | OMOP |
|---|---|
| `subject_id` | `person_id` |
| `hadm_id` | `visit_occurrence_id` |
| `drug_name_generic` | `drug_concept_id` |
| `startdate` | `drug_exposure_start_date` |

**MEASUREMENT**
| Source | OMOP |
|---|---|
| `subject_id` | `person_id` |
| `hadm_id` | `visit_occurrence_id` |
| `itemid` | `measurement_id` |
| `value` | `value_as_number` |
| `valueuom` | `unit_concept_id` |
| `charttime` | `measurement_datetime` |

### 3. Standardisation des concepts (Athena)
Les valeurs des colonnes correspondant à des concepts (sexe, diagnostics, médicaments, unités de mesure) ont été converties en **CONCEPT ID** standardisés OMOP à l'aide d'**Athena**, via la correspondance *"Non-standard to Standard map"*.

<details>
<summary><b>Sexe (gender_concept_id)</b></summary>

| Valeur source | Concept ID |
|---|---|
| FEMALE | 8532 |
| MALE | 8507 |
</details>

<details>
<summary><b>Diagnostics (visit_source_value)</b></summary>

| Valeur source | Concept ID |
|---|---|
| Congestive heart failure | 319835 |
| Old inferior myocardial infarction | 4121467 |
| Stroke/TIA | 4053371 |
</details>

<details>
<summary><b>Médicaments (drug_concept_id)</b></summary>

| Médicament | NDC | Concept ID |
|---|---|---|
| Metoprolol | 51079080120 | 40167218 |
| Metoprolol XL | 186109039 | 40166831 |
| Lisinopril | 310013039 | 19003830 |
| Losartan Potassium | 71610037045 | 40185280 |
| Spironolactone | 51079010320 | 19079658 |
| Hydralazine | 63323061401 | 40174776 |
| Hydralazine HCl | 517090125 | 40174776 |
| Labetalol | 182820289 | 40169683 |
| Captopril | 904504561 | 19074672 |
| Atenolol | 51079075920 | 19018811 |
| Diltiazem | 51079074520 | 1328689 |
</details>

<details>
<summary><b>Unité de mesure (unit_concept_id)</b></summary>

| Valeur source | Concept ID |
|---|---|
| mm[Hg] | 8876 |
</details>

### 4. Transformation des données avec R
Le script R (`dplyr`, `ggplot2`) réalise, pour chaque table :
- le filtrage sur les patients et pathologies/médicaments d'intérêt,
- le remplacement des valeurs sources par leurs Concept ID OMOP,
- le renommage final des colonnes au format OMOP,
- l'export de chaque table transformée en CSV dans le dossier `Table_OMOP/`.

Un histogramme (`ggplot2`) du nombre total de prescriptions par médicament est généré à cette étape.

### 5. Requêtage SQL
Les fichiers CSV standardisés ont été importés sur **csvfiddle.io** afin de réaliser des requêtes SQL directement sur les données de l'entrepôt.

---

## 📊 Résultats

L'histogramme des prescriptions montre que le **Metoprolol** (`40167218`) est de loin le médicament le plus prescrit, avec **57 prescriptions**, suivi par l'**Hydralazine HCl** (`40174776`) avec **14 prescriptions**.

La requête SQL suivante permet d'obtenir le détail du nombre de prescriptions par patient et par médicament :

```sql
SELECT person_id AS patient, drug_concept_id AS médicament, COUNT(*) AS prescription
FROM DRUG_EXPOSURE
GROUP BY person_id, drug_concept_id
ORDER BY person_id, drug_concept_id;
```

Ce détail révèle par exemple que le patient `10088` s'est vu prescrire 23 fois du Metoprolol au cours de l'ensemble de ses hospitalisations.

---

## 📁 Structure du dépôt

```
.
├── Rapport_UE3.pdf              # Rapport complet du projet
├── script.R                     # Script de transformation R → OMOP
├── PERSON.csv                   # Table PERSON standardisée OMOP
├── VISIT_OCCURRENCE.csv         # Table VISIT_OCCURRENCE standardisée OMOP
├── CONDITION_OCCURRENCE.csv     # Table CONDITION_OCCURRENCE standardisée OMOP
├── DRUG_EXPOSURE.csv            # Table DRUG_EXPOSURE standardisée OMOP
├── MEASUREMENT.csv              # Table MEASUREMENT standardisée OMOP
└── README.md
```

## 🛠️ Outils utilisés

- **R** (`dplyr`, `ggplot2`) — transformation et standardisation des données
- **WhiteRabbit** / **Rabbit in a Hat** — mapping du schéma source vers OMOP CDM v5.4
- **Athena (OHDSI)** — recherche des Concept ID standardisés
- **csvfiddle.io** — requêtage SQL sur les CSV de l'entrepôt

## ▶️ Reproduire l'analyse

```r
# Prérequis
install.packages(c("dplyr", "ggplot2"))

# Placer les fichiers sources MIMIC-III (PATIENTS.csv, ADMISSIONS.csv,
# DIAGNOSES_ICD.csv, PRESCRIPTIONS.csv, CHARTEVENTS.csv) dans le même dossier
# que le script, puis exécuter :
Rscript script.R
```
Les tables standardisées sont générées dans le dossier `Table_OMOP/`.

---

## ⚠️ Limites et perspectives

- Les données de MIMIC-III Clinical Database Demo semblent en partie fictives : certaines dates de naissance sont postérieures à l'année en cours (le patient `43870` est par exemple né en 2097), ce qui affecte le calcul de l'âge des patients.
- L'échantillon de patients et de médicaments étudiés est restreint. Une extension à un plus grand nombre de patients et de traitements permettrait d'obtenir des résultats plus représentatifs.
- L'HTA étant déduite indirectement (via des pathologies associées) plutôt que diagnostiquée, les résultats reflètent une **probabilité** d'HTA plutôt qu'un diagnostic confirmé.

---

## 📚 Référence

1. OMS — [Hypertension](https://www.who.int/fr/news-room/fact-sheets/detail/hypertension)

---

*Projet réalisé dans le cadre du Master 2 Informatique Biomédicale — UE-3, 2024-2025.*
