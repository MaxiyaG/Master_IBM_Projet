library(dplyr)
library(ggplot2)

person <- read.csv("PATIENTS.csv", header = TRUE)
visit_occurence <- read.csv("ADMISSIONS.csv", header = TRUE)
condition_occurence <- read.csv("DIAGNOSES_ICD.csv", header = TRUE)
drug_exposure <- read.csv("PRESCRIPTIONS.csv", header = TRUE)
measurement <- read.csv("CHARTEVENTS.csv", header = TRUE)

# Elimination des attributs 

person <- person[, c("subject_id", "gender", "dob"), drop = FALSE]
visit_occurence <- visit_occurence[, c("subject_id", "hadm_id", "admittime", "dischtime", "diagnosis"), drop = FALSE]
condition_occurence <- condition_occurence[, c("subject_id", "hadm_id", "icd9_code"), drop = FALSE]
drug_exposure <- drug_exposure[, c("subject_id", "hadm_id", "drug_name_generic", "startdate"), drop = FALSE]
measurement <- measurement[, c("subject_id", "hadm_id", "itemid", "value", "valueuom", "charttime"), drop = FALSE]

# Traitement et Transformation des Valeurs

# Person

person$gender <- ifelse(person$gender == "F", "8532", 
                        ifelse(person$gender == "M", "8507", 
                               person$gender))
person$dob <- format(as.Date(person$dob), "%Y")
patient_list <- c(10026, 10088, 10111, 10124, 42075, 43870)
person <- person %>%
  filter(subject_id %in% patient_list)

# Visite Occurence

diagnoses_list <- c("STROKE/TIA", "INFERIOR MYOCARDIAL INFARCTION\\CATH", "CONGESTIVE HEART FAILURE")
visit_occurence <- visit_occurence %>%
  filter(diagnosis %in% diagnoses_list)

visit_occurence <- visit_occurence %>%
  mutate(diagnosis = case_when(
    diagnosis == "STROKE/TIA" ~ "4053371",
    diagnosis == "INFERIOR MYOCARDIAL INFARCTION\\CATH" ~ "4121467",
    diagnosis == "CONGESTIVE HEART FAILURE" ~ "319835",
    TRUE ~ diagnosis 
  ))

# Condition occurence

condition_occurence <- condition_occurence %>%
  filter(subject_id %in% patient_list)

# Drug Exposure

drug_list <- c(
  'Metoprolol',
  'Lisinopril',
  'HydrALAzine',
  'Hydralazine HCl',
  'Captopril',
  'Metoprolol XL',
  'Atenolol',
  'Losartan Potassium',
  'Diltiazem',
  'Spironolactone',
  'Labetalol'
)
drug_exposure <- drug_exposure %>%
  filter(drug_name_generic %in% drug_list) 
drug_exposure <- drug_exposure %>%
  filter(subject_id %in% patient_list) %>%
  mutate(startdate = as.Date(startdate))


drug_exposure <- drug_exposure %>%
  mutate(drug_name_generic = case_when(
    drug_name_generic == "Metoprolol" ~ "40167218",
    drug_name_generic == "Lisinopril" ~ "19003830",
    drug_name_generic == "Losartan Potassium" ~ "40185280",
    drug_name_generic == "Spironolactone" ~ "19079658",
    drug_name_generic == "HydrALAzine" ~ "40174776",
    drug_name_generic == "Hydralazine HCl" ~ "40174776",
    drug_name_generic == "Labetalol" ~ "40169683",
    drug_name_generic == "Captopril" ~ "19074672",
    drug_name_generic == "Atenolol" ~ "19018811",
    drug_name_generic == "Diltiazem" ~ "1328689",
    drug_name_generic == "Metoprolol XL" ~ "40166831"
  ))

# Histograme 

counts <- table(drug_exposure$drug_name_generic)
drug_counts <- as.data.frame(counts)
colnames(drug_counts) <- c("drug_name_generic", "total_prescriptions")

ggplot(drug_counts, aes(x = reorder(drug_name_generic, -total_prescriptions), y = total_prescriptions)) +
  geom_bar(stat = "identity", fill = "skyblue") +
  theme_minimal() +
  labs(
    title = "Nombre total de prescriptions par médicament de 2107-01-07 à 2166-02-21",
    x = "Médicament (drug_name_generic)",
    y = "Nombre de prescriptions"
  ) +
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
  scale_y_continuous(
    limits = c(0, max(drug_counts$total_prescriptions) + 1), 
    breaks = seq(0, max(drug_counts$total_prescriptions) + 1, by = 1) 
  )

rm(drug_counts)

# Measurement
measurement <- measurement %>%
  filter(valueuom == "mmHg")
measurement <- measurement %>%
  mutate(valueuom = case_when(
    valueuom == "mmHg" ~ "8876",
    TRUE ~ valueuom
  ))

# Renommage des attributs vers OMOP

names(person)[names(person) == "subject_id"] <- "person_id"
names(person)[names(person) == "gender"] <- "gender_concept_id"
names(person)[names(person) == "dob"] <- "year_of_birth"

names(visit_occurence)[names(visit_occurence) == "subject_id"] <- "person_id"
names(visit_occurence)[names(visit_occurence) == "hadm_id"] <- "visit_occurrence_id"
names(visit_occurence)[names(visit_occurence) == "admittime"] <- "visit_start_datetime"
names(visit_occurence)[names(visit_occurence) == "dischtime"] <- "visit_end_datetime"
names(visit_occurence)[names(visit_occurence) == "diagnosis"] <- "visit_source_value"

names(condition_occurence)[names(condition_occurence) == "subject_id"] <- "person_id"
names(condition_occurence)[names(condition_occurence) == "hadm_id"] <- "visit_occurrence_id"
names(condition_occurence)[names(condition_occurence) == "icd9_code"] <- "condition_source_value"

names(drug_exposure)[names(drug_exposure) == "subject_id"] <- "person_id"
names(drug_exposure)[names(drug_exposure) == "hadm_id"] <- "visit_occurrence_id"
names(drug_exposure)[names(drug_exposure) == "drug_name_generic"] <- "drug_concept_id"
names(drug_exposure)[names(drug_exposure) == "startdate"] <- "drug_exposure_start_date"

names(measurement)[names(measurement) == "subject_id"] <- "person_id"
names(measurement)[names(measurement) == "hadm_id"] <- "visit_occurrence_id"
names(measurement)[names(measurement) == "itemid"] <- "measurement_id"
names(measurement)[names(measurement) == "value"] <- "value_as_number"
names(measurement)[names(measurement) == "valueuom"] <- "unit_concept_id"
names(measurement)[names(measurement) == "charttime"] <- "measurement_datetime"

# Exportation des CSV

if (!dir.exists("Table_OMOP")) {
  dir.create("Table_OMOP")
}

write.csv(person, "Table_OMOP/PERSON.csv", row.names = FALSE)
write.csv(visit_occurence, "Table_OMOP/VISIT_OCCURRENCE.csv", row.names = FALSE)
write.csv(condition_occurence, "Table_OMOP/CONDITION_OCCURRENCE.csv", row.names = FALSE)
write.csv(drug_exposure, "Table_OMOP/DRUG_EXPOSURE.csv", row.names = FALSE)
write.csv(measurement, "Table_OMOP/MEASUREMENT.csv", row.names = FALSE)

