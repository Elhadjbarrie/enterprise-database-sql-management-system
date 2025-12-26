USE THE_RED_DB;
GO

INSERT INTO CLIENT (ID_CLIENT, NOM, TEL, COURRIEL, ADRESSE) VALUES
(1, 'Ali Ndiaye', '514-111-1111', 'ali.ndiaye@example.com', 'Montr�al'),
(2, 'Fatou Diop', '514-222-2222', 'fatou.diop@example.com', 'Laval'),
(3, 'Jean Tremblay', '514-333-3333', 'jean.tremblay@example.com', 'Gatineau'),
(4, 'Marie Dubois', '514-444-4444', 'marie.dubois@example.com', 'Qu�bec'),
(5, 'Ousmane Ba', '514-555-5555', 'ousmane.ba@example.com', 'Montr�al');
GO

INSERT INTO EMPLOYE (ID_EMPLOYE, NOM, ROLE, LOGIN, MOT_PASSE) VALUES
(1, 'Konare Mouhamadou', 'GESTIONNAIRE', 'mkonare', 'mdpHash1'),
(2, 'Barry Elhadj',       'VENDEUR',      'ebarry',  'mdpHash2'),
(3, 'Raima Pieme',        'COMPTABLE',    'rpieme',  'mdpHash3'),
(4, 'Sophie Martin',      'VENDEUR',      'smartin', 'mdpHash4'),
(5, 'David Roy',          'LOGISTICIEN',  'droy',    'mdpHash5');
GO

INSERT INTO CATEGORIE (ID_CATEGORI, NOM_CATEGORIE) VALUES
(1, 'V�tements'),
(2, 'Accessoires'),
(3, 'Chaussures'),
(4, 'Sacs'),
(5, 'Autres');
GO

INSERT INTO FOURNISSEUR (ID_FOURNISS, NOM, TELEPHONE, MAIL, ADRESSE) VALUES
(1, 'Fournisseur Mode Dakar', '+221-77-000-0000', 'contact@modedakar.sn', 'Dakar, S�n�gal'),
(2, 'Style Montr�al Inc.', '514-777-7777', 'info@stylemtl.ca', 'Montr�al, QC'),
(3, 'Paris Fashion Export', '+33-1-22-33-44-55', 'sales@parisfashion.fr', 'Paris, France'),
(4, 'Casual Wear Factory', '+1-212-000-9999', 'hello@casualwear.com', 'New York, USA'),
(5, 'StreetStyle Africa', '+221-78-123-4567', 'hello@streetafrica.sn', 'Thi�s, S�n�gal');
GO

INSERT INTO PRODUIT (ID_PRODUIT, NOM, DESCRIPTION, PRIX, ID_CATEGORI, ID_FOURNISS) VALUES
(1, 'T-shirt THE RED', 'T-shirt logo THE RED', 19.99, 1, 1),
(2, 'Pantalon slim noir', 'Pantalon slim homme', 39.99, 1, 2),
(3, 'Casquette rouge', 'Casquette brod�e THE RED', 14.99, 2, 1),
(4, 'Sneakers blanches', 'Chaussures unisexes', 59.99, 3, 3),
(5, 'Sac � dos urbain', 'Sac � dos polyvalent', 49.99, 4, 4);
GO

INSERT INTO STOCK (ID_STOCK, ID_PRODUIT, QTE_DISPO, DATE_MAJ) VALUES
(1, 1, 100, GETDATE()),
(2, 2, 50,  GETDATE()),
(3, 3, 200, GETDATE()),
(4, 4, 30,  GETDATE()),
(5, 5, 40,  GETDATE());
GO

INSERT INTO COMMANDE (ID_CMD, DATE_CMD, STATUT, ID_CLIENT, ID_EMPLY) VALUES
(1, '2024-11-01', 'LIVREE',   1, 2),
(2, '2024-11-02', 'EN COURS', 2, 2),
(3, '2024-11-03', 'EN COURS', 3, 4),
(4, '2024-11-04', 'ANNULEE',  4, 2),
(5, '2024-11-05', 'EN COURS', 5, 1);
GO

INSERT INTO LIGNE_COMMANDE (ID_CMD, ID_PRODUIT, QUANTITE, PRIX_UNITAIRE) VALUES
(1, 1, 2, 19.99),
(1, 3, 1, 14.99),
(2, 2, 1, 39.99),
(3, 4, 1, 59.99),
(5, 1, 3, 19.99);
GO

INSERT INTO FACTURE (ID_FACTURE, DATE, MONTANT, ID_CMD) VALUES
(1, '2024-11-01', 54.97, 1),
(2, '2024-11-02', 39.99, 2),
(3, '2024-11-03', 59.99, 3),
(4, '2024-11-04', 0.00,  4),
(5, '2024-11-05', 59.97, 5);
GO

INSERT INTO PAIEMENT (ID_PAIEMEN, DATE_PAIMT, MONTANT, MODE_PAIM, ID_CMD) VALUES
(1, '2024-11-01', 54.97, 'CARTE', 1),
(2, '2024-11-02', 39.99, 'CARTE', 2),
(3, '2024-11-03', 59.99, 'VIREMENT', 3),
(4, '2024-11-05', 59.97, 'ESPECES', 5),
(5, '2024-11-06', 10.00, 'ESPECES', 2); GO

INSERT INTO LIVRAISON (ID_LIVRAISN, DATE_ENVOI, DATE_RECEP, STATUT, ID_CMD, ID_FOURNISS, ID_EMPLOYE) VALUES
(1, '2024-11-01', '2024-11-03', 'LIVREE',     1, 1, 5),
(2, '2024-11-02', NULL,         'EN TRANSIT', 2, 2, 5),
(3, '2024-11-03', NULL,         'EN PREPARATION', 3, 3, 5),
(4, '2024-11-04', NULL,         'RETARDEE',   4, 1, 5),
(5, '2024-11-05', '2024-11-07', 'LIVREE',     5, 4, 5);
GO
use THE_RED_DB
INSERT INTO FOURNITURE_PRODUIT (ID_PRODUIT, ID_FOURNISS, PRIX_FOURNISSEUR, DELAI_LIVRAISON)
VALUES
(1, 1, 15.99, 3),
(1, 2, 14.99, 5),
(2, 1, 29.99, 4);
GO

INSERT INTO MAJ_STOCK (ID_STOCK, ID_EMPLOYE, DATE_MAJ, QUANTITE_MODIFIEE, TYPE_ACTION)
VALUES
(1, 5, '2024-11-10', 10, 'AJUSTEMENT'),
(1, 2, '2024-11-12', -5, 'VENTE'),
(2, 3, '2024-11-11', 20, 'REAPPROVISIONNEMENT');
GO
 
