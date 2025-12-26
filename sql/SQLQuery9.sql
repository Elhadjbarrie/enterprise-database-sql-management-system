--TESTING SCRIPT TO VERIFY THE STRUCTURE AND CONSTRAINTS OF THE DATABASE THE_RED_DB 
--  TEST SCRIPT POUR VERIFIER LA STRUCTURE ET LES CONTRAINTES DE LA BASE DE DONNEES THE_RED_DB
SELECT * FROM CLIENT;
SELECT COUNT(*) FROM PRODUIT;
INSERT INTO COMMANDE (ID_CMD, DATE_CMD, STATUT, ID_CLIENT, ID_EMPLY)
VALUES (999, '2024-11-10', 'EN COURS', 9999, 1);

INSERT INTO PRODUIT (ID_PRODUIT, NOM, PRIX, ID_CATEGORI)
VALUES (999, 'Produit Impossible', -10, 1,1 );

SELECT COUNT(*) FROM CLIENT;
SELECT COUNT(*) FROM EMPLOYE;
SELECT COUNT(*) FROM COMMANDE;
SELECT COUNT(*) FROM LIGNE_COMMANDE;
SELECT COUNT(*) FROM STOCK;
SELECT COUNT(*) FROM LIVRAISON;



SELECT name, create_date
FROM sys.views
ORDER BY name;


SELECT 
    t.name AS TableName,
    i.name AS IndexName,
    i.type_desc AS IndexType
FROM sys.indexes i
JOIN sys.tables t ON i.object_id = t.object_id
WHERE i.is_primary_key = 0 AND i.is_unique_constraint = 0
ORDER BY t.name, i.name;

PRINT '=== TABLES EXISTANTES ===';
SELECT name AS TableName
FROM sys.tables
ORDER BY name;


PRINT '=== CLES PRIMAIRES ===';
SELECT 
    t.name AS TableName,
    kc.name AS PrimaryKeyName,
    c.name AS ColumnName
FROM sys.key_constraints kc
JOIN sys.tables t ON kc.parent_object_id = t.object_id
JOIN sys.index_columns ic ON kc.unique_index_id = ic.index_id AND kc.parent_object_id = ic.object_id
JOIN sys.columns c ON ic.object_id = c.object_id AND ic.column_id = c.column_id
WHERE kc.type = 'PK'
ORDER BY t.name;


PRINT '=== CLES ETRANGERES (FOREIGN KEYS) ===';
SELECT 
    fk.name AS FK_Name,
    tp.name AS ParentTable,
    cp.name AS ParentColumn,
    tr.name AS ReferencedTable,
    cr.name AS ReferencedColumn
FROM sys.foreign_keys fk
JOIN sys.tables tp ON fk.parent_object_id = tp.object_id
JOIN sys.tables tr ON fk.referenced_object_id = tr.object_id
JOIN sys.foreign_key_columns fkc ON fk.object_id = fkc.constraint_object_id
JOIN sys.columns cp ON fkc.parent_object_id = cp.object_id AND fkc.parent_column_id = cp.column_id
JOIN sys.columns cr ON fkc.referenced_object_id = cr.object_id AND fkc.referenced_column_id = cr.column_id
ORDER BY ParentTable;


PRINT '=== INDEX ===';
SELECT 
    t.name AS TableName,
    i.name AS IndexName,
    i.type_desc AS IndexType
FROM sys.indexes i
JOIN sys.tables t ON i.object_id = t.object_id
WHERE i.is_primary_key = 0
  AND i.is_unique_constraint = 0
  AND i.name IS NOT NULL
ORDER BY t.name, i.name;


PRINT '=== NOMBRE D ENREGISTREMENTS PAR TABLE ===';
SELECT 
    t.name AS TableName,
    SUM(p.rows) AS NbRows
FROM sys.tables t
JOIN sys.partitions p ON t.object_id = p.object_id
WHERE p.index_id IN (0,1)
GROUP BY t.name
ORDER BY t.name;

PRINT '=== DEPENDANCES ENTRE OBJETS ===';
SELECT 
    referencing_object_name = o1.name,
    referencing_type = o1.type_desc,
    referenced_object_name = o2.name,
    referenced_type = o2.type_desc
FROM sys.sql_expression_dependencies d
JOIN sys.objects o1 ON d.referencing_id = o1.object_id
JOIN sys.objects o2 ON d.referenced_id = o2.object_id
ORDER BY o1.name;

-- TEST 1 : insertion valide
use THE_RED_DB
INSERT INTO FOURNITURE_PRODUIT (ID_PRODUIT, ID_FOURNISS, PRIX_FOURNISSEUR, DELAI_LIVRAISON)
VALUES (999, 1, 12.99, 4);

INSERT INTO FOURNITURE_PRODUIT (ID_PRODUIT, ID_FOURNISS, PRIX_FOURNISSEUR, DELAI_LIVRAISON)
VALUES (5, 1, 49.99, 4);
use THE_RED_DB
INSERT INTO MAJ_STOCK (ID_STOCK, ID_EMPLOYE, DATE_MAJ, QUANTITE_MODIFIEE, TYPE_ACTION)
VALUES (1, 2, GETDATE(), 5, 'TEST');

INSERT INTO MAJ_STOCK (ID_STOCK, ID_EMPLOYE, DATE_MAJ, QUANTITE_MODIFIEE, TYPE_ACTION)
VALUES (1, 2, GETDATE(), 10, 'AJUSTEMENT');

SELECT * FROM MAJ_STOCK;

SELECT * FROM FOURNITURE_PRODUIT;
SELECT * FROM PRODUIT 
SELECT * FROM FOURNISSEUR
SELECT * FROM CATEGORIE;

use THE_RED_DB
SELECT P.ID_PRODUIT, P.NOM AS PRODUIT,
       F.ID_FOURNISS, F.NOM AS FOURNISSEUR,
       FP.PRIX_FOURNISSEUR, FP.DELAI_LIVRAISON
FROM FOURNITURE_PRODUIT FP
JOIN PRODUIT P ON FP.ID_PRODUIT = P.ID_PRODUIT
JOIN FOURNISSEUR F ON FP.ID_FOURNISS = F.ID_FOURNISS;
          ------------------------
use THE_RED_DB
SELECT S.ID_STOCK, S.QTE_DISPO,
       E.ID_EMPLOYE, E.NOM AS EMPLOYE,
       M.DATE_MAJ, M.QUANTITE_MODIFIEE, M.TYPE_ACTION
FROM MAJ_STOCK M
JOIN STOCK S ON M.ID_STOCK = S.ID_STOCK
JOIN EMPLOYE E ON M.ID_EMPLOYE = E.ID_EMPLOYE;

----------------------------------
-- REQUETES SQL POUR LA BASE DE DONNEES THE_RED_DB

use THE_RED_DB
--Trois requêtes SQL simples avec une seule tables

-- 1. Liste de tous les clients
SELECT * FROM CLIENT;

-- 2. Liste des produits avec leur prix
SELECT ID_PRODUIT, NOM, PRIX
FROM PRODUIT;

-- 3. Liste des commandes avec leur statut
SELECT ID_CMD, DATE_CMD, STATUT
FROM COMMANDE;

--Trois SELECT avec une jointure + une condition

-- 1. Commandes passées par un client donné
SELECT C.NOM, CMD.ID_CMD, CMD.DATE_CMD
FROM CLIENT C
JOIN COMMANDE CMD ON C.ID_CLIENT = CMD.ID_CLIENT
WHERE C.NOM = 'Ali Ndiaye';

-- 2. Produits d’une catégorie donnée
SELECT P.NOM, CAT.NOM_CATEGORIE
FROM PRODUIT P
JOIN CATEGORIE CAT ON P.ID_CATEGORI = CAT.ID_CATEGORI
WHERE CAT.NOM_CATEGORIE = 'Accessoires';

-- 3. Livraisons en transit
SELECT ID_LIVRAISN, DATE_ENVOI, STATUT
FROM LIVRAISON
WHERE STATUT = 'EN TRANSIT';

--Deux SELECT avec deux jointures + conditions

-- 1. Produits commandés par un client
SELECT C.NOM, P.NOM AS PRODUIT, LC.QUANTITE
FROM CLIENT C
JOIN COMMANDE CMD ON C.ID_CLIENT = CMD.ID_CLIENT
JOIN LIGNE_COMMANDE LC ON CMD.ID_CMD = LC.ID_CMD
JOIN PRODUIT P ON LC.ID_PRODUIT = P.ID_PRODUIT
WHERE C.NOM = 'Fatou Diop';

-- 2. Livraisons avec fournisseur et employé responsable
SELECT L.ID_LIVRAISN, F.NOM AS FOURNISSEUR, E.NOM AS EMPLOYE
FROM LIVRAISON L
JOIN FOURNISSEUR F ON L.ID_FOURNISS = F.ID_FOURNISS
JOIN EMPLOYE E ON L.ID_EMPLOYE = E.ID_EMPLOYE
WHERE L.STATUT = 'LIVREE';

--Deux SELECT avec GROUP BY + HAVING

-- 1. Nombre de commandes par client
SELECT C.NOM, COUNT(CMD.ID_CMD) AS NB_COMMANDES
FROM CLIENT C
JOIN COMMANDE CMD ON C.ID_CLIENT = CMD.ID_CLIENT
GROUP BY C.NOM
HAVING COUNT(CMD.ID_CMD) >= 1;

-- 2. Montant total facturé par client
SELECT C.NOM, SUM(F.MONTANT) AS TOTAL_DEPENSE
FROM CLIENT C
JOIN COMMANDE CMD ON C.ID_CLIENT = CMD.ID_CLIENT
JOIN FACTURE F ON CMD.ID_CMD = F.ID_CMD
GROUP BY C.NOM
HAVING SUM(F.MONTANT) > 50;

-----Deux requêtes avec sous-requêtes----

-- 1. Produits plus chers que la moyenne
SELECT NOM, PRIX
FROM PRODUIT
WHERE PRIX > (SELECT AVG(PRIX) FROM PRODUIT);

-- 2. Clients ayant passé au moins une commande
SELECT NOM
FROM CLIENT
WHERE ID_CLIENT IN (
    SELECT ID_CLIENT FROM COMMANDE
);

--Trois VUES (différents types)

-- Vue 1 : Commandes par client
use THE_RED_DB
GO
CREATE VIEW V_COMMANDES_CLIENT AS
SELECT C.NOM, CMD.ID_CMD, CMD.DATE_CMD, CMD.STATUT
FROM CLIENT C
JOIN COMMANDE CMD ON C.ID_CLIENT = CMD.ID_CLIENT;
GO
-- Vue 2 : Détails des lignes de commande
CREATE VIEW VUE_DETAIL_COMMANDE AS
SELECT CMD.ID_CMD, P.NOM, LC.QUANTITE, LC.PRIX_UNITAIRE
FROM COMMANDE CMD
JOIN LIGNE_COMMANDE LC ON CMD.ID_CMD = LC.ID_CMD
JOIN PRODUIT P ON LC.ID_PRODUIT = P.ID_PRODUIT;
GO
-- Vue 3 : Livraisons complètes
CREATE VIEW V_LIVRAISONS_COMPLETES AS
SELECT L.ID_LIVRAISN, F.NOM AS FOURNISSEUR, E.NOM AS EMPLOYE, L.STATUT
FROM LIVRAISON L
JOIN FOURNISSEUR F ON L.ID_FOURNISS = F.ID_FOURNISS
JOIN EMPLOYE E ON L.ID_EMPLOYE = E.ID_EMPLOYE;
GO
--Deux procédures stockées

-- Procédure 1 : afficher les commandes d’un client
use THE_RED_DB
GO
CREATE PROCEDURE SP_Commandes_Client
    @NomClient VARCHAR(100)
AS
BEGIN
    SELECT C.NOM, CMD.ID_CMD, CMD.DATE_CMD
    FROM CLIENT C
    JOIN COMMANDE CMD ON C.ID_CLIENT = CMD.ID_CLIENT
    WHERE C.NOM = @NomClient;
END;
GO
-- Procédure 2 : total payé pour une commande
CREATE PROCEDURE SP_Total_Commande
    @IdCommande INT
AS
BEGIN
    SELECT SUM(MONTANT) AS TOTAL_PAYE
    FROM PAIEMENT
    WHERE ID_CMD = @IdCommande;
END;
GO
--Deux déclencheurs (TRIGGERS)
-- Trigger 1 : empêcher stock négatif
CREATE TRIGGER TRG_STOCK_NEGATIF
ON STOCK
AFTER UPDATE
AS
BEGIN
    IF EXISTS (
        SELECT * FROM inserted WHERE QTE_DISPO < 0
    )
    BEGIN
        ROLLBACK;
        THROW 50001, 'Stock insuffisant', 1;
    END
END;
GO
-- Trigger 2 : mise à jour automatique de la date de livraison
CREATE TRIGGER TRG_LIVRAISON_DATE
ON LIVRAISON
AFTER UPDATE
AS
BEGIN
    UPDATE LIVRAISON
    SET DATE_RECEP = GETDATE()
    WHERE STATUT = 'LIVREE' AND DATE_RECEP IS NULL;
END;