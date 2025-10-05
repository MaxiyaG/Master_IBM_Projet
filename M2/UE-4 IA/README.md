# 🧠 Identification des Interlocuteurs par Intelligence Artificielle dans les Appels du SAMU

**Master 2 Informatique Biomédicale — 2024-2025**  
**Projet UE-4**

---

## 📘 Description du projet

Ce projet a pour objectif de développer deux modèles d’intelligence artificielle capables d’**identifier automatiquement les interlocuteurs** (médecin / patient) dans les **conversations téléphoniques simulées du SAMU**.

Deux approches complémentaires ont été mises en œuvre :
- 🧩 **Approche classique** : Régression Logistique + TF-IDF
- 🤖 **Approche Deep Learning** : CamemBERT (modèle BERT francophone)

Les modèles ont été évalués sur leur **taux de précision**, avec un objectif minimal de **80 %**.

---

## 🧪 Partie 1 : Évaluation de Méthodes d’Apprentissage (Jeu de données Iris)

Avant de passer au traitement du langage, une étude comparative a été menée entre deux algorithmes sur le jeu de données **Iris** :
- 🌲 **Random Forest (supervisé)**
- 📊 **K-Means (non supervisé)**

**Résultat :**  
Le **Random Forest** surpasse largement le **K-Means**, atteignant entre **80 % et 100 % de précision**, démontrant la supériorité des méthodes supervisées lorsque les étiquettes sont connues.

---

## 💬 Partie 2 : Traitement Automatique des Langues (TAL)

### 🎯 Objectif

Déterminer automatiquement si une phrase d’un appel au SAMU est prononcée par :
- un **Médecin**
- un **Patient**

---

## 📂 Jeu de données

- **Nom :** [SimSamu](https://huggingface.co/datasets/medkit/simsamu)
- **Source :** [HuggingFace](https://huggingface.co/datasets/medkit/simsamu)
- **Structure :**
  - Fichiers `.srt` : transcriptions textuelles (avec timestamps)
  - Fichiers `.rttm` : identité des interlocuteurs (avec timestamps)

Les deux sources ont été **fusionnées** afin de créer un **dataset structuré** où chaque phrase est associée à l’interlocuteur correspondant.

📦 Référentiel du dataset : [https://github.com/manalland/simsamu](https://github.com/manalland/simsamu)

---

## ⚙️ Prétraitement

- Nettoyage du texte (suppression des caractères non alphabétiques et mots inutiles : *heu, bah, etc.*)
- Passage en minuscules
- Vectorisation avec **TF-IDF**
- Création d’une matrice **3061 × 2625** (phrases × termes)

---

## 🧩 Modèle Classique : Régression Logistique

- **Entrées** : Matrice TF-IDF
- **Pipeline** :
  1. Sélection des caractéristiques via **pénalisation L1**
  2. Classification avec **Régression Logistique**
- **Optimisation** : `GridSearchCV` pour le réglage des hyperparamètres
- **Évaluation** : Matrice de confusion + métriques de performance

**Résultats :**
| Classe   | Précision | Rappel | F1-score |
|----------|------------|---------|-----------|
| Médecin  | 0.79       | 0.86    | 0.82      |
| Patient  | 0.83       | 0.74    | 0.78      |

📈 **Précision globale : 80,42 %**

---

## 🤖 Modèle Deep Learning : CamemBERT (BERT Francophone)

- **Base :** `CamemBERTForSequenceClassification`
- **Encodage :** Tokenizer CamemBERT, max length = 128
- **Optimiseur :** `AdamW`
- **Fonction de perte :** `CrossEntropyLoss`
- **Techniques :** Régulation par température, prompts contextuels

### 🧠 Prompts testés :
- `default`  
- `question`  
- `contexte`  
- `rôle`  

Chaque prompt testé à trois températures : `0.5`, `1.0`, `2.0`.

**Meilleur résultat :**
- Prompt : `default`
- Température : `2.0`
- 🎯 **Précision : 82,71 %**

**Pire résultat :**
- Prompt : `question`
- Température : `0.5`
- ⚠️ **Précision : 59,05 %**

---

## 📊 Comparaison des Modèles

| Modèle | Approche | Précision | Points forts | Limites |
|--------|-----------|------------|--------------|----------|
| Régression Logistique | Classique (TF-IDF) | 80.42 % | Rapidité, simplicité | Moins sensible au contexte |
| CamemBERT | Deep Learning | 82.71 % | Compréhension contextuelle | Ressources élevées |

**Conclusion :**  
CamemBERT est **plus précis** grâce à sa capacité à saisir les nuances linguistiques, tandis que la régression logistique reste **rapide et robuste** sur des données limitées.

---

## 🚀 Environnement Technique

- 💻 **Plateforme** : Google Colab
- ⚙️ **GPU** : NVIDIA Tesla (accès gratuit limité)
- 🐍 **Langage** : Python 3
- 📚 **Librairies principales** :
  - `scikit-learn`
  - `pandas`
  - `numpy`
  - `matplotlib`
  - `transformers`
  - `torch`
  - `huggingface_hub`

---

## 🔮 Perspectives d’Amélioration

- 🔁 **Augmenter la taille du dataset** (équilibrer les classes)
- 🧩 **Affiner CamemBERT** avec un vocabulaire médical plus riche
- ⚖️ **Ajuster la pondération** pour réduire le biais sur la classe majoritaire
- 👥 **Étendre la classification** à d’autres rôles : *conjoint, parent, enfant, patient-médecin…*

---

## 📚 Références

- 🧾 Dataset : [SimSamu – HuggingFace](https://huggingface.co/datasets/medkit/simsamu)  
- 📦 Repo GitHub du dataset : [https://github.com/manalland/simsamu](https://github.com/manalland/simsamu)  
- 🤗 Documentation CamemBERT : [CamemBERT – HuggingFace](https://huggingface.co/docs/transformers/en/model_doc/camembert)  
- 📘 Article sur TF-IDF : [Medium – Claude Feldges](https://medium.com/@claude.feldges/text-classification-with-tf-idf-lstm-bert-a-quantitative-comparison-b8409b556cb3)

---

## 👤 Auteurs

Projet réalisé dans le cadre du **Master 2 Informatique Biomédicale**, UE-4, année **2024–2025**.  
Encadré par l’équipe pédagogique du parcours.

---
