# Scripts SQL du projet

Ce dossier contient les scripts SQL Server utilisés pour modéliser et tester la base de données **THE_RED_DB**. Les fichiers `SQLQuery1.sql` à `SQLQuery10.sql` créent le schéma principal de commerce, insèrent des données d'exemple et proposent des vues/index liés aux commandes et produits.

## Nouveau module de chat universitaire

Le fichier `SQLQuery11.sql` ajoute un module de messagerie pour une université. Il crée les tables suivantes :

- `DEPARTEMENT_UNIV` : référentiel des départements académiques.
- `ETUDIANT` : fiches étudiantes avec code permanent, nom, prénom, courriel et rattachement au département.
- `CHAT_CONVERSATION` : salons de type `GROUPE` ou `DIRECT` avec l'étudiant créateur.
- `CHAT_PARTICIPANT` : association des étudiants aux conversations avec rôle `MEMBRE` ou `ADMIN`.
- `CHAT_MESSAGE` : messages horodatés avec contenu textuel.

Le script ajoute des index pour les recherches par code permanent, nom/prénom et département, crée une vue `V_RECHERCHE_ETUDIANTS`, et insère un jeu de données de démonstration (3 départements, 5 étudiants, 3 conversations et leurs messages).

> Pour installer le module, exécutez `SQLQuery11.sql` après avoir créé la base via `SQLQuery1.sql`. Le script supprime les tables du module s'elles existent déjà afin de simplifier les ré-exécutions en environnement de développement.
