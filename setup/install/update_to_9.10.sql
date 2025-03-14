UPDATE `gaz_config` SET `cvalue` = '159' WHERE `id` =2;
DELETE FROM `gaz_config` WHERE  `variable`='last_update_exec';
DELETE FROM `gaz_menu_script` WHERE `link` LIKE '%prop_ordine.php%';
DELETE FROM `gaz_menu_module` WHERE `link` = 'report_pagdeb.php';
DROP TABLE IF EXISTS `gaz_anagraes`;
CREATE TABLE IF NOT EXISTS `gaz_anagra_chiper` (
  `id_anagraes` varchar(200) NOT NULL,
  `id_anagraes_bidx` varchar(8) DEFAULT NULL,
  `ragso1` varchar(300) DEFAULT NULL,
  `ragso1_bidx` varchar(8) DEFAULT NULL,
  `ragso2` varchar(300) DEFAULT NULL,
  `ragso2_bidx` varchar(8) DEFAULT NULL,
  `sedleg` varchar(300) DEFAULT NULL,
  `legrap_pf_nome` varchar(200) DEFAULT NULL,
  `legrap_pf_cognome` varchar(200) DEFAULT NULL,
  `sexper` varchar(160) DEFAULT NULL,
  `datnas` varchar(200) DEFAULT NULL,
  `luonas` varchar(200) DEFAULT NULL,
  `pronas` varchar(160) DEFAULT NULL,
  `counas` varchar(200) DEFAULT NULL,
  `indspe` varchar(300) DEFAULT NULL,
  `capspe` varchar(200) DEFAULT NULL,
  `citspe` varchar(250) DEFAULT NULL,
  `prospe` varchar(160) DEFAULT NULL,
  `country` varchar(160) DEFAULT NULL,
  `telefo` varchar(200) DEFAULT NULL,
  `fax` varchar(200) DEFAULT NULL,
  `cell` varchar(200) DEFAULT NULL,
  `codfis` varchar(200) DEFAULT NULL,
  `codfis_bidx` varchar(8) DEFAULT NULL,
  `pariva` varchar(200) DEFAULT NULL,
  `pariva_bidx` varchar(8) DEFAULT NULL,
  `fe_cod_univoco` varchar(200) DEFAULT NULL,
  `e_mail` varchar(200) DEFAULT NULL,
  `e_mail2` varchar(200) DEFAULT NULL,
  `pec_email` varchar(200) DEFAULT NULL,
  `adminid` varchar(20) DEFAULT NULL,
  `last_modified` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  KEY `id_anagraes_bidx` (`id_anagraes_bidx`),
  KEY `ragso1_bidx` (`ragso1_bidx`),
  KEY `ragso2_bidx` (`ragso2_bidx`),
  KEY `codfis_bidx` (`codfis_bidx`),
  KEY `pariva_bidx` (`pariva_bidx`)
) COMMENT='Archivia le anagrafiche criptate, predisposta per contenere gli indici delle colonne indicizzate/ricercabili usando la libreria ChiperSweet';
CREATE TABLE IF NOT EXISTS `gaz_banned_ip` (
  `id` int NOT NULL AUTO_INCREMENT,
  `reference` varchar(50) DEFAULT NULL COMMENT 'referenza al tipo di richiesta fallita',
  `ipv4` varchar(15) DEFAULT NULL,
  `ipv6` varchar(45) DEFAULT NULL,
  `last_url` varchar(200) NOT NULL DEFAULT '',
  `attempts` int NOT NULL,
  `last_attempt` timestamp NOT NULL DEFAULT (now()) ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `ipv4` (`ipv4`),
  KEY `ipv6` (`ipv6`),
  KEY `last_attempt` (`last_attempt`),
  KEY `reference` (`reference`)
) ENGINE=MyISAM COMMENT='Tabella utilizzabile sui moduli personalizzati per bannare gli IP dai quali arrivano tentativi falliti ';
INSERT INTO `gaz_config` (`description`, `variable`, `cvalue`) SELECT 'Numero e giorni periodicità backup (separati da virgola) ', 'keep_backup', '52,7' FROM `gaz_config` WHERE (`variable`='keep_backup') HAVING COUNT(*) = 0;
UPDATE `gaz_config` SET `description`='Numero e giorni periodicità backup (separati da virgola) ', `cvalue`='52,7' WHERE  `variable`='keep_backup';
ALTER TABLE `gaz_destina`	ADD INDEX (`id_anagra`);
CREATE TABLE IF NOT EXISTS `gaz_calendar` (
  `day` int NOT NULL,
  `month` int NOT NULL,
  `holiday` tinyint DEFAULT NULL,
  `info` varchar(255) DEFAULT NULL,
  `iso_country` varchar(2) NOT NULL DEFAULT 'IT',
  KEY `month` (`month`),
  KEY `day` (`day`),
  KEY `iso_country` (`iso_country`)
) ENGINE=MyISAM;
INSERT INTO `gaz_calendar` (`day`, `month`, `holiday`, `info`, `iso_country`) VALUES
	(1, 1, 1, 'Maria Santissima Madre di Dio, San Fulgenzio di Ruspe e San Giustino', 'IT'),
	(2, 1, NULL, 'San Basilio Magno, San Giovanni il Buono e San Telesforo', 'IT'),
	(3, 1, NULL, 'Santa Genoveffa, San Daniele di Padova', 'IT'),
	(4, 1, NULL, 'Sant\'Angela da Foligno, Santa Elisabetta Anna Bayley Seton', 'IT'),
	(5, 1, NULL, 'Beata Maria Repetto, Sant\'Emiliana e San Carlo di Sant\'Andrea', 'IT'),
	(6, 1, 1, 'Epifania del Signore', 'IT'),
	(7, 1, NULL, 'San Luciano di Antiochia, San Raimondo di Peñafort', 'IT'),
	(8, 1, NULL, 'San Severino del Norico e San Lorenzo Giustiniani', 'IT'),
	(9, 1, NULL, 'San Marcellino di Ancona, Beato Antonio Fatati e Sant\'Adriano di Canterbury', 'IT'),
	(10, 1, NULL, 'San Paolo di Tebe, San Gregorio di Nissa e Sant\'Aldo', 'IT'),
	(11, 1, NULL, 'San Igino, Santa Liberata e San Paolino d\'Aquileia', 'IT'),
	(12, 1, NULL, 'Santa Taziana (Tatiana), San Bernardo da Corleone', 'IT'),
	(13, 1, NULL, 'Sant\'Ilario di Poitiers, San Remigio di Reims', 'IT'),
	(14, 1, NULL, 'San Felice da Nola, Sant\'Engelmaro Martire', 'IT'),
	(15, 1, NULL, 'San Mauro, Sant\'Efisio e Sant\'Arnoldo Janssen', 'IT'),
	(16, 1, NULL, 'San Marcello I, San Tiziano, Beato Giuseppe Tovini', 'IT'),
	(17, 1, NULL, 'Sant\'Antonio Abate, San Gennaro Sánchez Delgadillo', 'IT'),
	(18, 1, NULL, 'Santa Margherita d\'Ungheria, Santa Prisca, Beata Maria Teresa Fasce', 'IT'),
	(19, 1, NULL, 'San Bassiano, San Marcello Spinola y Maestre', 'IT'),
	(20, 1, NULL, 'San Fabiano, San Sebastiano', 'IT'),
	(21, 1, NULL, 'Santa Agnese', 'IT'),
	(22, 1, NULL, 'San Vincenzo di Saragozza, San Gaudenzio di Novara', 'IT'),
	(23, 1, NULL, 'San Emerenziana, Sant\'Ildefonso', 'IT'),
	(24, 1, NULL, 'San Feliciano di Foligno, Sant\'Esuperanzio, San Francesco di Sales', 'IT'),
	(25, 1, NULL, 'Beato Enrico Susone, Beato Antonio Migliorati', 'IT'),
	(26, 1, NULL, 'San Tito, San Timoteo', 'IT'),
	(27, 1, NULL, 'San Giuliano, Sant\'Angela Merici e Santa Devota', 'IT'),
	(28, 1, NULL, 'San Tommaso d\'Aquino', 'IT'),
	(29, 1, NULL, 'San Valerio di Treviri, Sant\'Aquilino', 'IT'),
	(30, 1, NULL, 'Santa Martina, Santa Giacinta Marescotti', 'IT'),
	(31, 1, NULL, 'San Giovanni Bosco, Sant\'Aidano', 'IT'),
	(1, 2, NULL, 'Sant\'Orso di Aosta', 'IT'),
	(2, 2, NULL, 'Santa Caterina de\' Ricci', 'IT'),
	(3, 2, NULL, 'San Biagio', 'IT'),
	(4, 2, NULL, 'San Giuseppe da Leonessa, San Gilberto di Sempringham', 'IT'),
	(5, 2, NULL, 'Sant\'Agata, Sant\'Adelaide di Vilich', 'IT'),
	(6, 2, NULL, 'San Dorotea, San Paolo Miki e compagni', 'IT'),
	(7, 2, NULL, 'San Teodoro di Amasea, Beato Rizzerio da Muccia', 'IT'),
	(8, 2, NULL, 'San Paolo Verdun, San Girolamo Emiliani', 'IT'),
	(9, 2, NULL, 'S. Apollonia, San Sabino di Canosa', 'IT'),
	(10, 2, NULL, 'Santa Scolastica, Beata Chiara da Rimini', 'IT'),
	(11, 2, NULL, 'Beata Vergine Maria di Lourdes, Santa Eloisa', 'IT'),
	(12, 2, NULL, 'Santi Martiri di Abitene, San Melezio', 'IT'),
	(13, 2, NULL, 'Sante Fosca, Santa Maura, Santa Ermenilda di Ely', 'IT'),
	(14, 2, NULL, 'San Valentino, San Cirillo', 'IT'),
	(15, 2, NULL, 'San Faustino e Giovita, San Claudio de La Colombière', 'IT'),
	(16, 2, NULL, 'Santa Giuliana di Nicomedia, Beato Giuseppe Allamano', 'IT'),
	(17, 2, NULL, 'San Flaviano, Beato Luca Belludi', 'IT'),
	(18, 2, NULL, 'Santa Geltrude Comensoli, Sant\'Angilberto, Beato Giovanni da Fiesole, San Francesco Régis Clet', 'IT'),
	(19, 2, NULL, 'San Barbato di Benevento, San Corrado Confalonieri', 'IT'),
	(20, 2, NULL, 'Sant\'Eleuterio di Tournai, Sant\'Eucherio d\'Orléans, Beato Pietro da Treia', 'IT'),
	(21, 2, NULL, 'San Pier Damiani', 'IT'),
	(22, 2, NULL, 'Santa Margherita da Cortona, Beata Isabella di Francia', 'IT'),
	(23, 2, NULL, 'San Policarpo, Beata Raffaella Ybarra da Villalonga', 'IT'),
	(24, 2, NULL, 'San Sergio di Cesarea, Beato Tommaso Maria Fusco', 'IT'),
	(25, 2, NULL, 'San Nestore, Beato Domenico Lentini', 'IT'),
	(26, 2, NULL, 'San Porfirio di Gaza, Santa Paola di San Giuseppe Calasanzio', 'IT'),
	(27, 2, NULL, 'San Gabriele dell\'Addolorata, Beata Maria di Gesù Deluil-Martiny', 'IT'),
	(28, 2, NULL, 'San Romano di Condat, Sant\'Augusto Chapdelaine', 'IT'),
	(29, 2, NULL, 'Sant\'Ilario, Sant\'Osvaldo, Beata Antonia da Firenze', 'IT'),
	(1, 3, NULL, 'Sant\'Albino di Angers, Sant\'Albino di Vercelli', 'IT'),
	(2, 3, NULL, 'San Quinto il Taumaturgo, Sant\'Agnese di Boemia', 'IT'),
	(3, 3, NULL, 'Santa Teresa Eustochio Verzeri, Beato Pietro Renato Rogue, Sant\'Anselmo di Nonantola', 'IT'),
	(4, 3, NULL, 'San Casimiro di Polonia, San Giovanni Antonio Farina, Beata Anna di Gesù (Anna de Lobera)', 'IT'),
	(5, 3, NULL, 'San Giovanni Giuseppe della Croce, San Lucio I, San Ciarano (Kieran)', 'IT'),
	(6, 3, NULL, 'Santa Rosa da Viterbo, San Marciano di Tortona', 'IT'),
	(7, 3, NULL, 'Santa Teresa Margherita Redi, Sante Perpetua e Felicita', 'IT'),
	(8, 3, NULL, 'San Giovanni di Dio', 'IT'),
	(9, 3, NULL, 'Santa Francesca Romana', 'IT'),
	(10, 3, NULL, 'San Macario di Gerusalemme', 'IT'),
	(11, 3, NULL, 'Santa Rosina di Wenglingen', 'IT'),
	(12, 3, NULL, 'San Massimiliano di Tebessa', 'IT'),
	(13, 3, NULL, 'Santa Eufrasia di Nicomedia', 'IT'),
	(14, 3, NULL, 'Santa Matilde di Germania', 'IT'),
	(15, 3, NULL, 'Santa Luisa de Marillac', 'IT'),
	(16, 3, NULL, 'Sant\'Eriberto di Colonia', 'IT'),
	(17, 3, NULL, 'San Patrizio', 'IT'),
	(18, 3, NULL, 'San Cirillo di Gerusalemme', 'IT'),
	(19, 3, NULL, 'San Giuseppe', 'IT'),
	(20, 3, NULL, 'Santa Maria Giuseppa del Cuore di Gesù (Sancho de Guerra)', 'IT'),
	(21, 3, NULL, 'Santa Benedetta Cambiagio Frassinello', 'IT'),
	(22, 3, NULL, 'San Benvenuto Scotivoli', 'IT'),
	(23, 3, NULL, 'San Giuseppe Oriol', 'IT'),
	(24, 3, NULL, 'Santa Caterina di Svezia', 'IT'),
	(25, 3, NULL, 'Sant\'Isacco', 'IT'),
	(26, 3, NULL, 'SS. Emanuele e compagni', 'IT'),
	(27, 3, NULL, 'S. Augusta di Serravalle', 'IT'),
	(28, 3, NULL, 'Santo Stefano Harding', 'IT'),
	(29, 3, NULL, 'Beato Bertoldo', 'IT'),
	(30, 3, NULL, 'San Secondo', 'IT'),
	(31, 3, NULL, 'Santa Balbina', 'IT'),
	(1, 4, NULL, 'Santa Maria Egiziaca, San Lodovico Pavoni', 'IT'),
	(2, 4, NULL, 'San Francesco da Paola, Beata Elisabetta Vendramini', 'IT'),
	(3, 4, NULL, 'San Sisto I, San Luigi Scrosoppi', 'IT'),
	(4, 4, NULL, 'San Benedetto da San Fratello (il Moro), San Francesco Marto', 'IT'),
	(5, 4, NULL, 'Santa Giuliana di Cornillon (o di Liegi), Santa Caterina Thomas', 'IT'),
	(6, 4, NULL, 'San Pietro da Verona, Beata Caterina Morigi da Pallanza', 'IT'),
	(7, 4, NULL, 'San Giovanni Battista de La Salle, Sant\'Ermanno Giuseppe di Colonia', 'IT'),
	(8, 4, NULL, 'San Amanzio di Como, San Dionigi di Corinto', 'IT'),
	(9, 4, NULL, 'San Demetrio, Santa Casilda di Toledo', 'IT'),
	(10, 4, NULL, 'Beato Marco Fantuzzi, Santa Maddalena di Canossa', 'IT'),
	(11, 4, NULL, 'Beato Angelo Carletti da Chivasso, San Stanislao', 'IT'),
	(12, 4, NULL, 'San Saba il Goto, San Giulio I', 'IT'),
	(13, 4, NULL, 'San Martino I, San Ermenegildo', 'IT'),
	(14, 4, NULL, 'San Benedetto di Hermillon, Santa Liduina Vergine', 'IT'),
	(15, 4, NULL, 'San Damiano de Veuster, San Cesare De Bus', 'IT'),
	(16, 4, NULL, 'San Contardo d\'Este, San Benedetto Giuseppe Labre', 'IT'),
	(17, 4, NULL, 'San Roberto di La Chaise-Dieu, San Donnano e compagni', 'IT'),
	(18, 4, NULL, 'San Galdino, Sant\'Atanasia di Egina', 'IT'),
	(19, 4, NULL, 'San Leone IX Papa, San Geroldo', 'IT'),
	(20, 4, NULL, 'Sant\'Agnese Segni di Montepulciano', 'IT'),
	(21, 4, NULL, 'Sant\'Anselmo di Aosta', 'IT'),
	(22, 4, NULL, 'San Teodoro il Siceota', 'IT'),
	(23, 4, NULL, 'San Giorgio, Beata Maria Gabriella Sagheddu', 'IT'),
	(24, 4, NULL, 'San Fedele da Sigmaringen, Santa Maria Eufrasia Pelletier', 'IT'),
	(25, 4, 1, 'Festa della Liberazione - San Marco, San Pietro di Betancour', 'IT'),
	(26, 4, NULL, 'San Cleto, San Marcellino', 'IT'),
	(27, 4, NULL, 'San Simeone di Gerusalemme, Santa Zita', 'IT'),
	(28, 4, NULL, 'Santa Valeria di Milano, Santa Gianna Beretta Molla', 'IT'),
	(29, 4, NULL, 'Santa Caterina da Siena', 'IT'),
	(30, 4, NULL, 'San Pio V', 'IT'),
	(1, 5, 1, 'Festa dei Lavoratori - San Geremia', 'IT'),
	(2, 5, NULL, 'Sant\'Atanasio', 'IT'),
	(3, 5, NULL, 'San Giacomo il Minore', 'IT'),
	(4, 5, NULL, 'San Floriano di Lorch', 'IT'),
	(5, 5, NULL, 'San Gottardo di Hildesheim', 'IT'),
	(6, 5, NULL, 'San Venerio di Milano', 'IT'),
	(7, 5, NULL, 'Sant\'Agostino Roscelli', 'IT'),
	(8, 5, NULL, 'Sant\'Amato Ronconi', 'IT'),
	(9, 5, NULL, 'San Isaia', 'IT'),
	(10, 5, NULL, 'San Giobbe', 'IT'),
	(11, 5, NULL, 'San Gengolfo', 'IT'),
	(12, 5, NULL, 'San Nereo e Achilleo', 'IT'),
	(13, 5, NULL, 'Beata Vergine Maria di Fatima', 'IT'),
	(14, 5, NULL, 'San Mattia', 'IT'),
	(15, 5, NULL, 'Sant\'Isidoro l\'agricoltore', 'IT'),
	(16, 5, NULL, 'San Pellegrino d\'Auxerre', 'IT'),
	(17, 5, NULL, 'San Emiliano I', 'IT'),
	(18, 5, NULL, 'San Giovanni I', 'IT'),
	(19, 5, NULL, 'San Teofilo da Corte Frate Minore Francescano', 'IT'),
	(20, 5, NULL, 'San Bernardino da Siena Sacerdote', 'IT'),
	(21, 5, NULL, 'San Carlo Eugenio de Mazenod', 'IT'),
	(22, 5, NULL, 'Santa Giulia', 'IT'),
	(23, 5, NULL, 'San Giovanni De Rossi', 'IT'),
	(24, 5, NULL, 'Maria Ausiliatrice', 'IT'),
	(25, 5, NULL, 'San Beda il venerabile', 'IT'),
	(26, 5, NULL, 'San Desiderio di Vienne', 'IT'),
	(27, 5, NULL, 'San Bruno di Würzburg', 'IT'),
	(28, 5, NULL, 'San Germano di Parigi', 'IT'),
	(29, 5, NULL, 'Santa Bona da Pisa', 'IT'),
	(30, 5, NULL, 'Santa Giovanna d\'Arco', 'IT'),
	(31, 5, NULL, 'la visitazione della Beata Vergine Maria', 'IT'),
	(1, 6, NULL, 'San Giustino', 'IT'),
	(2, 6, 1, 'Festa della Repubblica - San Guido di Acqui', 'IT'),
	(3, 6, NULL, 'Santa Clotilde', 'IT'),
	(4, 6, NULL, 'San Francesco Caracciolo', 'IT'),
	(5, 6, NULL, 'San Bonifacio', 'IT'),
	(6, 6, NULL, 'San Norberto', 'IT'),
	(7, 6, NULL, 'Beata Anna di San Bartolomeo', 'IT'),
	(8, 6, NULL, 'San Medardo', 'IT'),
	(9, 6, NULL, 'San Primo, San Feliciano', 'IT'),
	(10, 6, NULL, 'San Bogumilo', 'IT'),
	(11, 6, NULL, 'San Barnaba', 'IT'),
	(12, 6, NULL, 'Beato Guido da Cortona', 'IT'),
	(13, 6, NULL, 'Sant\'Antonio di Padova', 'IT'),
	(14, 6, NULL, 'Sant\'Eliseo', 'IT'),
	(15, 6, NULL, 'San Vito', 'IT'),
	(16, 6, NULL, 'Santa Lutgarda', 'IT'),
	(17, 6, NULL, 'San Ranieri di Pisa', 'IT'),
	(18, 6, NULL, 'San Gregorio Giovanni Barbarigo', 'IT'),
	(19, 6, NULL, 'San Romualdo Abate', 'IT'),
	(20, 6, NULL, 'San Giovanni da Matera', 'IT'),
	(21, 6, NULL, 'San Luigi Gonzaga', 'IT'),
	(22, 6, NULL, 'San Paolino di Nola', 'IT'),
	(23, 6, NULL, 'San Giuseppe Cafasso', 'IT'),
	(24, 6, NULL, 'Santa Maria Guadalupe Garcia Zavala', 'IT'),
	(25, 6, NULL, 'San Massimo di Torino', 'IT'),
	(26, 6, NULL, 'San Vigilio di Trento', 'IT'),
	(27, 6, NULL, 'San Cirillo di Alessandria', 'IT'),
	(28, 6, NULL, 'Sant\'Ireneo di Lione', 'IT'),
	(29, 6, NULL, 'Santi Pietro e Paolo', 'IT'),
	(30, 6, NULL, 'San Basilide di Alessandria', 'IT'),
	(1, 7, NULL, 'Sant\'Aronne', 'IT'),
	(2, 7, NULL, 'San Bernardino Realino', 'IT'),
	(3, 7, NULL, 'San Tommaso Apostolo', 'IT'),
	(4, 7, NULL, 'Sant\'Antonio Daniel', 'IT'),
	(5, 7, NULL, 'Sant\'Antonio Maria Zaccaria', 'IT'),
	(6, 7, NULL, 'Santa Maria Goretti', 'IT'),
	(7, 7, NULL, 'Beato Benedetto XI', 'IT'),
	(8, 7, NULL, 'Santi Aquila e Priscilla', 'IT'),
	(9, 7, NULL, 'Beata Maria di Gesù crocifisso (Maria Petkovic)', 'IT'),
	(10, 7, NULL, 'Sante Seconda e Rufina, San Canuto IV', 'IT'),
	(11, 7, NULL, 'San Pio I, San Benedetto da Norcia', 'IT'),
	(12, 7, NULL, 'Santi Ermagora e Fortunato, Santa Veronica', 'IT'),
	(13, 7, NULL, 'Sant\'Enrico II', 'IT'),
	(14, 7, NULL, 'San Camillo de Lellis', 'IT'),
	(15, 7, NULL, 'San Bonaventura', 'IT'),
	(16, 7, NULL, 'Beata Vergine Maria del Monte Carmelo', 'IT'),
	(17, 7, NULL, 'Sant\'Alessio', 'IT'),
	(18, 7, NULL, 'Sant\'Arnolfo di Metz, San Bruno di Segni', 'IT'),
	(19, 7, NULL, 'Sant\'Arsenio il Grande', 'IT'),
	(20, 7, NULL, 'Sant\'Apollinare', 'IT'),
	(21, 7, NULL, 'Santa Prassede', 'IT'),
	(22, 7, NULL, 'Santa Maria Maddalena', 'IT'),
	(23, 7, NULL, 'Sant\'Ezechiele', 'IT'),
	(24, 7, NULL, 'San Fantino il vecchio', 'IT'),
	(25, 7, NULL, 'San Giacomo il', 'IT'),
	(26, 7, NULL, 'Santi Anna e Gioacchino', 'IT'),
	(27, 7, NULL, 'San Pantaleone', 'IT'),
	(28, 7, NULL, 'Santi Nazario e Celso', 'IT'),
	(29, 7, NULL, 'Santa Marta di Betania', 'IT'),
	(30, 7, NULL, 'San Pietro Crisologo', 'IT'),
	(31, 7, NULL, 'Sant\'Ignazio di Loyola', 'IT'),
	(1, 8, NULL, 'San Pietro Favre', 'IT'),
	(2, 8, NULL, 'Sant\'Eusebio di Vercelli', 'IT'),
	(3, 8, NULL, 'Sant\'Aspreno di Napoli', 'IT'),
	(4, 8, NULL, 'San Giovanni Maria Vianney', 'IT'),
	(5, 8, NULL, 'Sant\'Emidio', 'IT'),
	(6, 8, NULL, 'Beata Maria Francesca di Gesù', 'IT'),
	(7, 8, NULL, 'Sant\'Alberto degli Abati (da Trapani)', 'IT'),
	(8, 8, NULL, 'Santa Bonifacia Rodriguez Castro, San Domenico di Guzmán', 'IT'),
	(9, 8, NULL, 'San Romano di Roma', 'IT'),
	(10, 8, NULL, 'San Lorenzo', 'IT'),
	(11, 8, NULL, 'Santa Chiara', 'IT'),
	(12, 8, NULL, 'Santa Giovanna Francesca del Chantal', 'IT'),
	(13, 8, NULL, 'Sant\'Ippolito', 'IT'),
	(14, 8, NULL, 'San Massimiliano Maria Kolbe', 'IT'),
	(15, 8, 1, 'Ferragosto - Assunzione di Maria, San Tarcisio di Roma', 'IT'),
	(16, 8, NULL, 'San Rocco', 'IT'),
	(17, 8, NULL, 'Santa Beatrice de Silva Meneses', 'IT'),
	(18, 8, NULL, 'Sant\'Agapito Martire', 'IT'),
	(19, 8, NULL, 'San Giovanni Eudes', 'IT'),
	(20, 8, NULL, 'San Samuele', 'IT'),
	(21, 8, NULL, 'San Pio X', 'IT'),
	(22, 8, NULL, 'Beata Vergine Maria Regina', 'IT'),
	(23, 8, NULL, 'Santa Rosa da Lima', 'IT'),
	(24, 8, NULL, 'San Bartolomeo', 'IT'),
	(25, 8, NULL, 'San Ludovico (Luigi IX), re di Francia', 'IT'),
	(26, 8, NULL, 'Sant\'Alessandro', 'IT'),
	(27, 8, NULL, 'Santa Monica', 'IT'),
	(28, 8, NULL, 'Sant\'Agostino', 'IT'),
	(29, 8, NULL, 'Santa Sabina', 'IT'),
	(30, 8, NULL, 'Santa Margherita Ward', 'IT'),
	(31, 8, NULL, 'San Giuseppe di Arimatea', 'IT'),
	(1, 9, NULL, 'Sant\' Egidio Abate', 'IT'),
	(2, 9, NULL, 'Sant\'Elpidio', 'IT'),
	(3, 9, NULL, 'San Gregorio I detto Magno', 'IT'),
	(4, 9, NULL, 'Santa Ida', 'IT'),
	(5, 9, NULL, 'S. Teresa di Calcutta', 'IT'),
	(6, 9, NULL, 'Santa Zaccaria', 'IT'),
	(7, 9, NULL, 'Santa Regina di Alise', 'IT'),
	(8, 9, NULL, 'S. Adriano di Nicomedia', 'IT'),
	(9, 9, NULL, 'S. Pietro Claver', 'IT'),
	(10, 9, NULL, 'San Nicola da Tolentino', 'IT'),
	(11, 9, NULL, 'Beato Ludovico IV', 'IT'),
	(12, 9, NULL, 'San Guido di Anderlecht', 'IT'),
	(13, 9, NULL, 'San Maurilio di Angers', 'IT'),
	(14, 9, NULL, 'Sant\'Alberto di Gerusalemme', 'IT'),
	(15, 9, NULL, 'Santa Caterina da Genova', 'IT'),
	(16, 9, NULL, 'San Cornelio', 'IT'),
	(17, 9, NULL, 'San Satiro di Milano', 'IT'),
	(18, 9, NULL, 'Santa Riccarda di Svevia', 'IT'),
	(19, 9, NULL, 'San Gennaro', 'IT'),
	(20, 9, NULL, 'Sant\'Eustachio', 'IT'),
	(21, 9, NULL, 'San Matteo', 'IT'),
	(22, 9, NULL, 'San Settimio di Jesi', 'IT'),
	(23, 9, NULL, 'San Pio da Pietrelcina', 'IT'),
	(24, 9, NULL, 'San Pacifico Divini', 'IT'),
	(25, 9, NULL, 'San Cleofa', 'IT'),
	(26, 9, NULL, 'San Cosma e Damiano', 'IT'),
	(27, 9, NULL, 'San Adolfo e Giovanni', 'IT'),
	(28, 9, NULL, 'San Venceslao', 'IT'),
	(29, 9, NULL, 'San Michele Arcangelo', 'IT'),
	(30, 9, NULL, 'Santa Rachele', 'IT'),
	(1, 10, NULL, 'Santa Teresa del Bambin Gesù', 'IT'),
	(2, 10, NULL, 'Santi Angeli Custodi', 'IT'),
	(3, 10, NULL, 'San Dionigi l\'Areopagita', 'IT'),
	(4, 10, NULL, 'San Francesco d\'Assisi', 'IT'),
	(5, 10, NULL, 'Santa Faustina Kowalska', 'IT'),
	(6, 10, NULL, 'San Bruno', 'IT'),
	(7, 10, NULL, 'Santa Giustina di Padova', 'IT'),
	(8, 10, NULL, 'San Ugo da Genova', 'IT'),
	(9, 10, NULL, 'S. Abramo', 'IT'),
	(10, 10, NULL, 'San Daniele e Compagni', 'IT'),
	(11, 10, NULL, 'San Giovanni XXIII', 'IT'),
	(12, 10, NULL, 'S. Massimiliano di Celeia', 'IT'),
	(13, 10, NULL, 'Beata Maddalena Panattieri', 'IT'),
	(14, 10, NULL, 'San Gaudenzio di Rimini', 'IT'),
	(15, 10, NULL, 'Santa Teresa d\'Avila', 'IT'),
	(16, 10, NULL, 'Santa Margherita Maria Alacoque', 'IT'),
	(17, 10, NULL, 'Sant\'Ignazio di Antiochia', 'IT'),
	(18, 10, NULL, 'San Luca', 'IT'),
	(19, 10, NULL, 'San Paolo della Croce', 'IT'),
	(20, 10, NULL, 'Santa Maria Bertilla Boscardin', 'IT'),
	(21, 10, NULL, 'SS. Orsola e Compagne', 'IT'),
	(22, 10, NULL, 'San Giovanni Paolo II', 'IT'),
	(23, 10, NULL, 'San Severino Boezio', 'IT'),
	(24, 10, NULL, 'Sant\'Antonio Maria Claret', 'IT'),
	(25, 10, NULL, 'S. Gaudenzio di Brescia', 'IT'),
	(26, 10, NULL, 'San Folco Scotti', 'IT'),
	(27, 10, NULL, 'San Evaristo', 'IT'),
	(28, 10, NULL, 'San Simone', 'IT'),
	(29, 10, NULL, 'San Narciso di Gerusalemme', 'IT'),
	(30, 10, NULL, 'San Saturnino di Cagliari', 'IT'),
	(31, 10, NULL, 'Santa Lucilla', 'IT'),
	(1, 11, 1, 'Tutti i Santi', 'IT'),
	(2, 11, NULL, 'San Giusto di Trieste', 'IT'),
	(3, 11, NULL, 'Santa Silvia', 'IT'),
	(4, 11, NULL, 'San Carlo Borromeo', 'IT'),
	(5, 11, NULL, 'San Domenico Mau', 'IT'),
	(6, 11, NULL, 'San Emiliano', 'IT'),
	(7, 11, NULL, 'Sant\'Ercolano di Perugia', 'IT'),
	(8, 11, NULL, 'San Goffredo di Amiens', 'IT'),
	(9, 11, NULL, 'S. Elisabetta della Trinità', 'IT'),
	(10, 11, NULL, 'San Baudolino', 'IT'),
	(11, 11, NULL, 'San Martino di Tours', 'IT'),
	(12, 11, NULL, 'San Diego di Alcalà', 'IT'),
	(13, 11, NULL, 'San Brizio di Tours', 'IT'),
	(14, 11, NULL, 'San Serapio', 'IT'),
	(15, 11, NULL, 'Sant\'Alberto Magno', 'IT'),
	(16, 11, NULL, 'Santa Margherita di Scozia', 'IT'),
	(17, 11, NULL, 'San Gregorio', 'IT'),
	(18, 11, NULL, 'San Oddone di Cluny', 'IT'),
	(19, 11, NULL, 'Beato Giacomo Benfatti', 'IT'),
	(20, 11, NULL, 'San Edmondo', 'IT'),
	(21, 11, NULL, 'San Gelasio', 'IT'),
	(22, 11, NULL, 'Santa Cecilia', 'IT'),
	(23, 11, NULL, 'San Colombano', 'IT'),
	(24, 11, NULL, 'Santa Fermina', 'IT'),
	(25, 11, NULL, 'Santa Caterina di Alessandria', 'IT'),
	(26, 11, NULL, 'San Corrado di Costanza', 'IT'),
	(27, 11, NULL, 'S. Virgilio di Salisburgo', 'IT'),
	(28, 11, NULL, 'S. Sòstene', 'IT'),
	(29, 11, NULL, 'San Saturnino di Tolosa', 'IT'),
	(30, 11, NULL, 'Sant\'Andrea', 'IT'),
	(1, 12, NULL, 'Sant\'Eligio', 'IT'),
	(2, 12, NULL, 'Santa Bibiana', 'IT'),
	(3, 12, NULL, 'San Francesco Saverio', 'IT'),
	(4, 12, NULL, 'Santa Barbara', 'IT'),
	(5, 12, NULL, 'San Dalmazio', 'IT'),
	(6, 12, NULL, 'San Nicola', 'IT'),
	(7, 12, NULL, 'Sant\'Ambrogio', 'IT'),
	(8, 12, 1, 'Immacolata Concezione della Beata Vergine Maria', 'IT'),
	(9, 12, NULL, 'Santa Valeria di Limoges', 'IT'),
	(10, 12, NULL, 'Beata Vergine Maria di Loreto', 'IT'),
	(11, 12, NULL, 'San Damaso I', 'IT'),
	(12, 12, NULL, 'Nostra Signora di Guadalupe', 'IT'),
	(13, 12, NULL, 'Santa Lucia', 'IT'),
	(14, 12, NULL, 'San Giovanni della Croce', 'IT'),
	(15, 12, NULL, 'Santa Virginia Centurione Bracelli', 'IT'),
	(16, 12, NULL, 'Sant\'Adelaide', 'IT'),
	(17, 12, NULL, 'Santa Olimpia', 'IT'),
	(18, 12, NULL, 'San Malachia', 'IT'),
	(19, 12, NULL, 'Santa Fausta Romana', 'IT'),
	(20, 12, NULL, 'San Vincenzo Romano', 'IT'),
	(21, 12, NULL, 'San Pietro Canisio', 'IT'),
	(22, 12, NULL, 'Santa Francesca Saverio Cabrini', 'IT'),
	(23, 12, NULL, 'San Servolino il Paralitico', 'IT'),
	(24, 12, NULL, 'San Giacobbe', 'IT'),
	(25, 12, 1, 'Natale del Signore', 'IT'),
	(26, 12, 1, 'Santo Stefano', 'IT'),
	(27, 12, NULL, 'Santa Fabiola', 'IT'),
	(28, 12, NULL, 'San Mattia Nazzarei', 'IT'),
	(29, 12, NULL, 'San Davide', 'IT'),
	(30, 12, NULL, 'San Felice I', 'IT'),
	(31, 12, NULL, 'San Silvestro I', 'IT');
INSERT INTO `gaz_menu_module` SELECT MAX(id)+1, (SELECT id FROM `gaz_module` WHERE `name`='inform'), 'calendar_select.php', '', '', 9, '', 9  FROM `gaz_menu_module`;
ALTER TABLE `gaz_languages`	CHANGE COLUMN `image` `image_jpg` TEXT NOT NULL COMMENT 'base64 encoded' AFTER `sef`, ADD COLUMN `image_svg` TEXT NOT NULL AFTER `image_jpg`, ADD COLUMN `emoji` VARCHAR(50) NOT NULL DEFAULT '' COMMENT 'base64 encoded' AFTER `image_svg`;
UPDATE `gaz_languages` SET `image_svg`='<?xml version="1.0" encoding="UTF-8" standalone="no"?><svg width="150" height="100" viewBox="0 0 3 2" version="1.1" id="svg3" xmlns="http://www.w3.org/2000/svg" xmlns:svg="http://www.w3.org/2000/svg"><defs id="defs3"/><rect width="3" height="2" fill="#009246" id="rect1"/><rect width="2" height="2" x="1" fill="#fff" id="rect2"/><rect width="1" height="2" x="2" fill="#ce2b37" id="rect3"/></svg>\n' WHERE  `lang_id`=1;
UPDATE `gaz_languages` SET `image_svg`='<?xml version="1.0" encoding="UTF-8" standalone="no"?><svg version="1.1" viewBox="0 0 150 100" id="svg15" width="150" height="100" xmlns="http://www.w3.org/2000/svg" xmlns:svg="http://www.w3.org/2000/svg"><defs id="defs15" /><g transform="matrix(0.48372413,0,0,0.49132313,-106.40306,-211.56369)" id="g15"><g transform="matrix(2.8449,0,0,2.9076,-1304.9,-535.77)" id="g14"><rect x="585" y="332.35999" width="11" height="70" color="#000000" fill="#f10002" id="rect1" /><rect x="536" y="361.35999" width="109" height="12" color="#000000" fill="#f10002" id="rect2" /><g transform="translate(61,-105)" id="g4"><path d="m 487,437.36 35,25 v -25 h -35" fill="#092c70" id="path2" /><path d="m 475,443.36 v 21 h 31 l -31,-21" fill="#092c70" id="path3" /><path d="m 475,437.36 v 3 l 36,24 h 5 l -41,-27" fill="#f10002" id="path4" /></g><g transform="matrix(-1,0,0,1,1120,-105)" id="g7"><path d="m 487,437.36 35,25 v -25 h -35" fill="#092c70" id="path5" /><path d="m 475,443.36 v 21 h 31 l -31,-21" fill="#092c70" id="path6" /><path d="m 475,437.36 v 3 l 36,24 h 5 l -41,-27" fill="#f10002" id="path7" /></g><g transform="rotate(180,560,419.86)" id="g10"><path d="m 487,437.36 35,25 v -25 h -35" fill="#092c70" id="path8" /><path d="m 475,443.36 v 21 h 31 l -31,-21" fill="#092c70" id="path9" /><path d="m 475,437.36 v 3 l 36,24 h 5 l -41,-27" fill="#f10002" id="path10" /></g><g transform="matrix(-1,0,0,1,1058,-62)" id="g13"><path d="m 487,437.36 35,25 v -25 h -35" fill="#092c70" id="path11" /><path d="m 475,443.36 v 21 h 31 l -31,-21" fill="#092c70" id="path12" /><path d="m 475,437.36 v 3 l 36,24 h 5 l -41,-27" fill="#f10002" id="path13" /></g></g></g></svg>' WHERE  `lang_id`=2;
UPDATE `gaz_languages` SET `image_svg`='<?xml version="1.0" encoding="UTF-8" standalone="no"?><svg width="150" height="100" version="1.1" id="svg2" xmlns="http://www.w3.org/2000/svg" xmlns:svg="http://www.w3.org/2000/svg"><defs id="defs2" /><rect width="150" height="100" fill="#ad1519" stroke-width="0.199998" id="rect1" x="0" y="0" /><rect y="25" width="150" height="50" fill="#fabd00" stroke-width="0.199998" id="rect2" x="0" /></svg>
' WHERE  `lang_id`=3;
UPDATE `gaz_languages` SET `emoji`='8J+HrvCfh7k=',`title`='Italiano',`title_native`='Italian', `image_jpg`='' WHERE `lang_id`=1;
UPDATE `gaz_languages` SET `emoji`='8J+HrPCfh6c=',`title`='English',`title_native`='English', `image_jpg`='' WHERE `lang_id`=2;
UPDATE `gaz_languages` SET `emoji`='8J+HqvCfh7g=',`title`='Español',`title_native`='Spanish', `image_jpg`='' WHERE `lang_id`=3;
ALTER TABLE `gaz_anagra` CHANGE COLUMN `latitude` `latitude` DECIMAL(9,6) NOT NULL AFTER `id_language`,	CHANGE COLUMN `longitude` `longitude` DECIMAL(9,6) NOT NULL AFTER `latitude`;
-- START_WHILE ( questo e' un tag che serve per istruire install.php ad INIZIARE ad eseguire le query seguenti su tutte le aziende dell'installazione)
ALTER TABLE `gaz_XXXtesdoc`	ADD COLUMN `tipdoc_buf` CHAR(3) NOT NULL DEFAULT '' COMMENT 'Quando tipdoc sarà valorizzato con "BUF", potrò utilizzare questa colonna per indicare il valore che dovrà assumere la colonna tipdoc alla conferma del contenuto del documento che si sta inserendo, questo eviterà in futuro (o a chi personalizza qualche interfaccia utente) di fare il POST di tutti i righi già immessi superando il limite attuale imposto dalla direttiva  max_input_vars del PHP. In sostanza si potrà mettere sempre e subito tutto sul database man mano che vengono inseriti i righi per poi valorizzare con il giusto tipdoc alla conferma. Il tipdoc=BUF dovrà essere uno solo per ogni utente (colonna adminid) e quindi ripulito ad ogni nuovo documento perché potrebbe essere rimasto in sospeso con un precedente documento mai confermato' AFTER `tipdoc`, ADD INDEX `tipdoc_buf` (`tipdoc_buf`);
ALTER TABLE `gaz_XXXtesbro`	ADD COLUMN `tipdoc_buf` CHAR(3) NOT NULL DEFAULT '' COMMENT 'Quando tipdoc sarà valorizzato con "BUF", potrò utilizzare questa colonna per indicare il valore che dovrà assumere la colonna tipdoc alla conferma del contenuto del documento che si sta inserendo, questo eviterà in futuro (o a chi personalizza qualche interfaccia utente) di fare il POST di tutti i righi già immessi superando il limite attuale imposto dalla direttiva  max_input_vars del PHP. In sostanza si potrà mettere sempre e subito tutto sul database man mano che vengono inseriti i righi per poi valorizzare con il giusto tipdoc alla conferma. Il tipdoc=BUF dovrà essere uno solo per ogni utente (colonna adminid) e quindi ripulito ad ogni nuovo documento perché potrebbe essere rimasto in sospeso con un precedente documento mai confermato' AFTER `tipdoc`, ADD COLUMN `id_signature` INT NULL DEFAULT NULL COMMENT 'riferimento ad id_body tabella gaz_NNNbody_text per contenere l\'eventuale firma (immagine/elettronica) ' AFTER `initra`, ADD INDEX `tipdoc_buf` (`tipdoc_buf`);
ALTER TABLE `gaz_XXXtesmov`	ADD COLUMN `caucon_buf` CHAR(3) NOT NULL DEFAULT '' COMMENT 'Quando caucon sarà valorizzato con "BUF", potrò utilizzare questa colonna per indicare il valore che dovrà assumere la colonna caucon alla conferma del contenuto del movimento che si sta inserendo, questo eviterà in futuro o a chi personalizza l\'interfaccia utente di fare il POST di tutti i righi già immessi superando il limite attuale imposto dalla direttiva  max_input_vars del PHP. In sostanza si potrà mettere sempre e subito tutto sul database man mano che vengono inseriti i righi per poi valorizzare con la giusta causale alla conferma. Il tipdoc=BUF dovrà essere uno solo per ogni utente (colonna adminid) e quindi ripulito ad ogni nuovo movimento contabile perché potrebbe essere rimasto in sospeso con un precedente  mai confermato' AFTER `caucon`, ADD INDEX `caucon` (`caucon`), ADD INDEX `caucon_buf` (`caucon_buf`);
ALTER TABLE `gaz_XXXrigbro`	ADD COLUMN `nrow` INT NOT NULL DEFAULT '0' COMMENT 'Numero del rigo sul documento' AFTER `id_rig`, ADD COLUMN `nrow_linked` INT NOT NULL DEFAULT '0' COMMENT 'Numero del rigo al quale è vincolato. Ad esempio un rigo tipo 6 (testo) derivante dalla descrizione estesa di un articolo/servizio di magazzino ' AFTER `nrow`,	ADD INDEX `nrow` (`nrow`), ADD INDEX `nrow_linked` (`nrow_linked`);
ALTER TABLE `gaz_XXXrigdoc`	ADD COLUMN `nrow` INT NOT NULL DEFAULT '0' COMMENT 'Numero del rigo sul documento' AFTER `id_rig`, ADD COLUMN `nrow_linked` INT NOT NULL DEFAULT '0' COMMENT 'Numero del rigo al quale è vincolato. Ad esempio un rigo tipo 6 (testo) derivante dalla descrizione estesa di un articolo/servizio di magazzino o, ad esempio, per creare task per la gestione dei diagrammi di Gantt' AFTER `nrow`,	ADD INDEX `nrow` (`nrow`), ADD INDEX `nrow_linked` (`nrow_linked`);
ALTER TABLE `gaz_XXXdistinta_base` ADD COLUMN `sort_order` INT NOT NULL COMMENT 'Per ordinamento visualizzazione componente, ad esempio su esplodo della distinta base' AFTER `id_movmag`,	ADD INDEX `sort_order` (`sort_order`);
ALTER TABLE `gaz_XXXartico`	ADD COLUMN `sort_order` INT NOT NULL COMMENT 'Per ordinamento articolo, ad esempio su catalogo' AFTER `ref_ecommerce_id_product`,	ADD INDEX `sort_order` (`sort_order`);
ALTER TABLE `gaz_XXXcatmer`	ADD COLUMN `sort_order` INT NOT NULL COMMENT 'Per ordinamento categoria merceologica, ad esempio su catalogo' AFTER `ref_ecommerce_id_category`, ADD INDEX `sort_order` (`sort_order`);
ALTER TABLE `gaz_XXXassets` ADD COLUMN `sort_order` INT NOT NULL COMMENT 'Per ordinamento bene strumentale, ad esempio su libro cespiti' AFTER `codice_artico`, ADD INDEX `sort_order` (`sort_order`);
UPDATE `gaz_XXXcompany_config` SET `val`= '2' WHERE `var` = 'ext_artico_description';
UPDATE `gaz_XXXcompany_config` SET `description`= 'Attiva lo scroll automatico sull\'ultimo rigo dei documenti (0= No, 1= Si, 9= No, ma con rigo input in testa)' WHERE `var` = 'autoscroll_to_last_row';
ALTER TABLE `gaz_XXXstaff` ADD COLUMN `codice_campi` INT(10) NULL DEFAULT NULL COMMENT 'riferimento alla tabella gaz_NNNcampi (reparto o luogo di lavoro)' AFTER `employment_status`;
ALTER TABLE `gaz_XXXstaff_work_movements`	ADD COLUMN `codice_campi` INT(10) NULL DEFAULT NULL COMMENT 'riferimento alla tabella gaz_NNNcampi per indicare il luogo/reparto dove è stato eseguito il lavoro' AFTER `id_orderman`, ADD INDEX `codice_campi` (`codice_campi`);
ALTER TABLE `gaz_XXXstaff_worked_hours`
	CHANGE COLUMN `hours_normal` `hours_normal` DECIMAL(4,2) NOT NULL AFTER `work_day`,
	CHANGE COLUMN `hours_extra` `hours_extra` DECIMAL(4,2) NOT NULL AFTER `id_work_type_extra`,
	CHANGE COLUMN `hours_absence` `hours_absence` DECIMAL(4,2) NOT NULL AFTER `id_absence_type`,
	CHANGE COLUMN `hours_other` `hours_other` DECIMAL(4,2) NOT NULL AFTER `id_other_type`;
ALTER TABLE `gaz_XXXrigdoc`	ADD INDEX (`id_orderman`);
ALTER TABLE `gaz_XXXmovmag`	ADD INDEX (`id_orderman`);
INSERT INTO `gaz_XXXcompany_data` (`id_ref`, `description`, `var`, `data`, `ref`, `adminid`, `last_modified`) VALUES (1, 'di acquisto', 'preacq', 'Listino di acquisto', 'italian_artico_pricelist', '', '2025-01-01 00:00:00');
INSERT INTO `gaz_XXXcompany_data` (`id_ref`, `description`, `var`, `data`, `ref`, `adminid`, `last_modified`) VALUES (2, 'vendita 1', 'preve1', 'Listino di vendita 1', 'italian_artico_pricelist', '', '2025-01-01 00:00:00');
INSERT INTO `gaz_XXXcompany_data` (`id_ref`, `description`, `var`, `data`, `ref`, `adminid`, `last_modified`) VALUES (3, 'vendita 2', 'preve2', 'Listino di vendita 2', 'italian_artico_pricelist', '', '2025-01-01 00:00:00');
INSERT INTO `gaz_XXXcompany_data` (`id_ref`, `description`, `var`, `data`, `ref`, `adminid`, `last_modified`) VALUES (4, 'vendita 3', 'preve3', 'Listino di vendita 3', 'italian_artico_pricelist', '', '2025-01-01 00:00:00');
INSERT INTO `gaz_XXXcompany_data` (`id_ref`, `description`, `var`, `data`, `ref`, `adminid`, `last_modified`) VALUES (5, 'vendita 4', 'preve4', 'Listino di vendita 4', 'italian_artico_pricelist', '', '2025-01-01 00:00:00');
INSERT INTO `gaz_XXXcompany_data` (`id_ref`, `description`, `var`, `data`, `ref`, `adminid`, `last_modified`) VALUES (6, 'vendita web', 'web_price', 'Listino di vendita web', 'italian_artico_pricelist', '', '2025-01-01 00:00:00');
ALTER TABLE `gaz_XXXeffett` CHANGE COLUMN `id_con` `id_con` INT NOT NULL DEFAULT '0' COMMENT 'Riferimento ad id_tes del movimento contabile (gaz_NNNtesmov) generato dall\'effetto, se -1 è un RID insoluto il cui movimento contabile è stato cancellato' AFTER `id_doc`,	ADD COLUMN `id_ins` INT NOT NULL DEFAULT '0' COMMENT 'Riferimento ad id_tes del movimento contabile (gaz_NNNtesmov) generato da un eventuale insoluto' AFTER `id_con`, ADD INDEX `id_ins` (`id_ins`);
UPDATE `gaz_XXXcompany_config` SET `description`='Numerazione delle Fatture separate da quella di Note Credito/Debito (0=No-DEFAULT 1=Si)', `val`='0' WHERE  `var`='num_note_separate';
ALTER TABLE `gaz_XXXclfoco`	CHANGE COLUMN `id_anagra` `id_anagra` INT NOT NULL COMMENT 'Se id_anagra è negativo fa riferimento alla tabella gaz_anagra_chiper (anagrafica criptata)' AFTER `codice`;
ALTER TABLE `gaz_XXXbody_text` ADD COLUMN `code_ref` VARCHAR(100) NOT NULL DEFAULT '' AFTER `id_ref`,	ADD COLUMN `descri` VARCHAR(1000) NOT NULL DEFAULT '' AFTER `body_text`, ADD INDEX `code_ref` (`code_ref`);
ALTER TABLE `gaz_XXXclfoco`	ADD COLUMN `max_overdraft` DECIMAL(10,2) NULL COMMENT 'massimo scoperto (fido/credito commerciale)' AFTER `maxrat`, ADD COLUMN `commercial_reliability` TINYINT NULL DEFAULT NULL COMMENT 'livello di affidabilità commerciale: 0 = non quantificato, da 1=inaffidabile (rischio altissimo) a 9 = affidabile (rischio bassissimo)' AFTER `max_overdraft`;
UPDATE gaz_XXXbody_text bt SET bt.code_ref = SUBSTRING_INDEX(bt.table_name_ref, '_', -1) WHERE bt.table_name_ref LIKE 'artico%';
-- STOP_WHILE ( questo e' un tag che serve per istruire install.php a SMETTERE di eseguire le query su tutte le aziende dell'installazione )
