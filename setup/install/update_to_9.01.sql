UPDATE `gaz_config` SET `cvalue` = '151' WHERE `id` =2;
ALTER TABLE `gaz_anagraes` COLLATE='utf8_general_ci';
-- START_WHILE ( questo e' un tag che serve per istruire install.php ad INIZIARE ad eseguire le query seguenti su tutte le aziende dell'installazione)
UPDATE gaz_XXXtesdoc SET data_ordine = datemi WHERE id_contract >= 1 AND data_ordine < 2020-01-01;
ALTER TABLE `gaz_XXXfae_flux` CHANGE `filename_ori` `filename_ori` VARCHAR(30) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL;
-- STOP_WHILE ( questo e' un tag che serve per istruire install.php a SMETTERE di eseguire le query su tutte le aziende dell'installazione )