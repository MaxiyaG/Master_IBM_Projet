# 📘 Projet UE-2 — Master 2 Informatique Biomédicale (2024-2025)
## 🧠 Systèmes d’Aide à la Décision Clinique — Cas de l’Hypertension Artérielle (HTA)

---

## 🎯 Objectif du Projet
L’objectif de ce travail est de concevoir, modéliser et comparer différents systèmes d’aide à la décision clinique (CDSS) appliqués à la **prise en charge thérapeutique de l’hypertension artérielle (HTA)**, en s’appuyant sur :

- Les **recommandations de la HAS (2016)**  
- Les **recommandations VidalRecos**  
- Le **système ASTI**  
- Des outils comme **DXplain** et **Thériaque**

Ce projet vise à développer une **base de règles décisionnelles consolidée** et à analyser la **cohérence** entre différentes sources, tout en identifiant les forces et limites des approches.

---

## 🏥 Contexte
L’HTA est une pathologie chronique fréquente nécessitant une prise en charge personnalisée.  
Le projet s’inscrit dans un cadre pédagogique visant à :
- Formaliser les recommandations cliniques sous forme de **règles SI–ALORS**
- Comparer différentes approches décisionnelles
- Simuler un outil d’aide au diagnostic et à la thérapeutique

---

## ⚙️ Méthodologie

### 1. Aide au Diagnostic (Inspirée de DXplain)
Une maquette fonctionnelle simule la **collecte des données cliniques** :
- Informations patient : tension artérielle, antécédents, comorbidités
- Facteurs de risque : diabète, tabagisme, insuffisance rénale
- Analyse automatique et **suggestions de pathologies possibles**

### 2. Aide à la Thérapeutique (Inspirée de Thériaque)
Une interface de recommandations personnalisées :
- Sélection de classes thérapeutiques selon profil patient
- Prise en compte des **contre-indications** et **interactions médicamenteuses**
- **Suivi longitudinal** du patient (consultations, ajustements, alertes)

---

## 🧩 Formalisation des Règles SI–ALORS

### 🧠 Variables de Décision (SI)
- Pression artérielle (PA)
- Risque cardiovasculaire global
- Tolérance au traitement
- Résistance ou échec thérapeutique
- Comorbidités (diabète, insuffisance rénale)

### 💡 Variables d’Action (ALORS)
- Règles hygiéno-diététiques
- Initiation ou modification du traitement antihypertenseur
- Surveillance biologique (créatininémie, kaliémie)
- Orientation vers un spécialiste

### 🧾 Exemples de Règles Consolidées
1. **SI** (PA ≥ 140/90 mmHg) ET (Risque cardiovasculaire faible)  
   **ALORS** Réévaluation tous les 3 à 6 mois.

2. **SI** (PA ≥ 180/110 mmHg) ET (Risque élevé ou atteinte d’organes cibles)  
   **ALORS** Initiation immédiate d’un traitement + réévaluation à 1 mois.

3. **SI** (Mauvaise tolérance au traitement)  
   **ALORS** Modification de la classe médicamenteuse.

4. **SI** (HTA résistante après trithérapie)  
   **ALORS** Orientation vers un spécialiste.

---

## 📊 Comparaison des Sources de Recommandations

| Critère | HAS 2016 | VidalRecos | ASTI | Modèle Consolidé |
|----------|-----------|-------------|------|------------------|
| Objectif tensionnel | <140/90 mmHg | <140/90 mmHg | Aligné | Aligné |
| Suivi | Mensuel puis trimestriel | Flexible | Régulier | Individualisé |
| Gestion HTA résistante | Spécialiste | Mention partielle | Oui | Oui |
| Comorbidités | Précisées | Oui | Oui | Intégrées |
| Règles hygiéno-diététiques | Oui | Oui | Oui | Oui |

Le modèle consolidé **harmonise les recommandations** en intégrant la rigueur de la HAS et la flexibilité de Vidal.

---

## 🧪 Études de Cas Cliniques

### Cas 1 : HTA modérée avec insuffisance rénale
- **Recommandation** : IEC + mesures hygiéno-diététiques
- **Suivi** : créatininémie, kaliémie

### Cas 2 : Intolérance (toux sèche)
- **Recommandation** : Remplacer IEC → ARA II
- **Alignement** : Règle 7 (mauvaise tolérance)

### Cas 3 : HTA non contrôlée
- **Recommandation** : Bithérapie ARA II + diurétique de l’anse
- **Option** : Trithérapie avec inhibiteur calcique

---

## 🔍 Discussion

- Les CDSS d’aide au diagnostic (**DXplain**) et à la thérapeutique (**Thériaque**) sont **complémentaires** :
  - Le premier identifie la pathologie
  - Le second propose un plan thérapeutique personnalisé

- L’utilisation combinée **réduit les erreurs** et **améliore la cohérence clinique**.

- L’intégration dans un **workflow clinique logique** est essentielle pour l’adoption :
  - Collecte → Analyse → Recommandation → Suivi

---

## 🧭 Conclusion

Ce projet a permis de :
- Formaliser les recommandations en **règles décisionnelles exploitables**
- Développer une **base consolidée** intégrant la HAS, Vidal, ASTI
- Mettre en évidence la **complémentarité** des outils CDSS
- Proposer une **approche personnalisée** pour la prise en charge de l’HTA

L’approche peut être étendue à d’autres pathologies chroniques nécessitant une **prise en charge complexe et dynamique**.
---

## 📚 Références
1. HAS — Recommandations de bonne pratique (2016)  
2. VidalRecos — Stratégies de prise en charge de l’HTA  
3. ASTI — Système d’aide à la décision thérapeutique  
4. Thériaque — Base de données médicamenteuse  
5. DXplain — Diagnostic Decision Support System

---
