<?php
/*
  --------------------------------------------------------------------------
  GAzie - Gestione Azienda
  Copyright (C) 2004-2021 - Antonio De Vincentiis Montesilvano (PE)
  (http://www.devincentiis.it)
  <http://gazie.sourceforge.net>
  --------------------------------------------------------------------------
  Questo programma e` free software;   e` lecito redistribuirlo  e/o
  modificarlo secondo i  termini della Licenza Pubblica Generica GNU
  come e` pubblicata dalla Free Software Foundation; o la versione 2
  della licenza o (a propria scelta) una versione successiva.
  Questo programma  e` distribuito nella speranza  che sia utile, ma
  SENZA   ALCUNA GARANZIA; senza  neppure  la  garanzia implicita di
  NEGOZIABILITA` o di  APPLICABILITA` PER UN  PARTICOLARE SCOPO.  Si
  veda la Licenza Pubblica Generica GNU per avere maggiori dettagli.
  Ognuno dovrebbe avere   ricevuto una copia  della Licenza Pubblica
  Generica GNU insieme a   questo programma; in caso  contrario,  si
  scriva   alla   Free  Software Foundation, 51 Franklin Street,
  Fifth Floor Boston, MA 02110-1335 USA Stati Uniti.
  --------------------------------------------------------------------------
 */
require("../../library/include/datlib.inc.php");
$admin_aziend = checkAdmin();

$_POST['id_staff']="1";
$card_res = gaz_dbi_dyn_query('id, start_work, end_work, id_work_type, min_delay, id_orderman', $gTables['staff_work_movements'], "id_staff = " . $_POST['id_staff']);

while ( $row = gaz_dbi_fetch_array($card_res) ) {// ciclo tutte le registrazioni
	$start = date('H:i', strtotime($row['start_work']));
	$end = date('H:i', strtotime($row['end_work']));
	$data[]=array("id"=>$row['id'], "start_work"=>$start, "end_work"=>$end, "id_work_type"=>$row['id_work_type'], "min_delay"=>$row['min_delay'], "id_orderman"=>$row['id_orderman']); 
}
$json= json_encode(array($data));
echo substr($json, 1, -1); // tolgo la prima e l ultima parentesi quadra
//echo "<pre>",print_r($data);die;
$test=array(array("uid"=>'successfuly registered', "col-1"=>'Antonio Germani', "col-2"=>'Massignano'));
//echo json_encode($test);
