<?php
/*
 --------------------------------------------------------------------------
                            GAzie - Gestione Azienda
    Copyright (C) 2004-present - Antonio De Vincentiis Montesilvano (PE)
         (https://www.devincentiis.it)
           <https://gazie.sourceforge.net>
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
$admin_aziend=checkAdmin();
$msg='';

function getMovements($date_ini,$date_fin)
    {
        global $gTables,$admin_aziend;
        $m=array();
        $where="good_or_service != '1' AND datreg BETWEEN $date_ini AND $date_fin";
        $what=$gTables['movmag'].".*, ".
              $gTables['caumag'].".codice, ".$gTables['caumag'].".descri, ".
              $gTables['clfoco'].".codice, ".$gTables['clfoco'].".descri AS ragsoc, ".
              $gTables['artico'].".codice, ".$gTables['artico'].".descri AS desart, ".$gTables['artico'].".unimis, ".$gTables['artico'].".scorta, ".$gTables['artico'].".catmer ";
        $table=$gTables['movmag']." LEFT JOIN ".$gTables['caumag']." ON (".$gTables['movmag'].".caumag = ".$gTables['caumag'].".codice)
               LEFT JOIN ".$gTables['clfoco']." ON (".$gTables['movmag'].".clfoco = ".$gTables['clfoco'].".codice)
               LEFT JOIN ".$gTables['artico']." ON (".$gTables['movmag'].".artico = ".$gTables['artico'].".codice)";
        $rs=gaz_dbi_dyn_query ($what,$table,$where, 'datreg ASC, tipdoc ASC, clfoco ASC, operat DESC, id_mov ASC');
        while ($r = gaz_dbi_fetch_array($rs)) {
            $m[] = $r;
        }
        return $m;
    }

if (!isset($_POST['hidden_req'])) { //al primo accesso allo script
    $form['hidden_req'] = '';
    $form['ritorno'] = $_SERVER['HTTP_REFERER'];
	$form['mode'] = "1";
	$form['price'] = "1";
	$form['subtitle']="";
    $form['this_date_Y']=date("Y");
    $form['this_date_M']=date("m");
    $form['this_date_D']=date("d");
    if (!isset($_GET['di'])) {
       $form['date_ini_D']=1;
       $form['date_ini_M']=1;
       $form['date_ini_Y']=date("Y");
    } else {
       $form['date_ini_D']=intval(substr($_GET['di'],0,2));
       $form['date_ini_M']=intval(substr($_GET['di'],2,2));
       $form['date_ini_Y']=intval(substr($_GET['di'],4,4));
    }
    if (!isset($_GET['df'])) {
       $form['date_fin_D']=date("d");
       $form['date_fin_M']=date("m");
       $form['date_fin_Y']=date("Y");
    } else {
       $form['date_fin_D']= intval(substr($_GET['df'],0,2));
       $form['date_fin_M']= intval(substr($_GET['df'],2,2));
       $form['date_fin_Y']= intval(substr($_GET['df'],4,4));
    }
} else { // accessi successivi
    $form['hidden_req']=htmlentities($_POST['hidden_req']);
    $form['ritorno']=$_POST['ritorno'];
	$form['mode'] = intval($_POST['mode']);
	$form['price'] = intval($_POST['price']);
	$form['subtitle'] = $_POST['subtitle'];
    $form['date_ini_D']=intval($_POST['date_ini_D']);
    $form['date_ini_M']=intval($_POST['date_ini_M']);
    $form['date_ini_Y']=intval($_POST['date_ini_Y']);
    $form['date_fin_D']=intval($_POST['date_fin_D']);
    $form['date_fin_M']=intval($_POST['date_fin_M']);
    $form['date_fin_Y']=intval($_POST['date_fin_Y']);
    $form['this_date_Y']=intval($_POST['this_date_Y']);
    $form['this_date_M']=intval($_POST['this_date_M']);
    $form['this_date_D']=intval($_POST['this_date_D']);
    if (isset($_POST['return'])) {
        header("Location: ".$form['ritorno']);
        exit;
    }
}

//controllo i campi
if (!checkdate( $form['this_date_M'],$form['this_date_D'],$form['this_date_Y']) ||
    !checkdate( $form['date_ini_M'], $form['date_ini_D'], $form['date_ini_Y']) ||
    !checkdate( $form['date_fin_M'], $form['date_fin_D'], $form['date_fin_Y'])) {
    $msg .='0+';
}
$utsexe= mktime(0,0,0,$form['this_date_M'],$form['this_date_D'],$form['this_date_Y']);
$utsini= mktime(0,0,0,$form['date_ini_M'],$form['date_ini_D'],$form['date_ini_Y']);
$utsfin= mktime(0,0,0,$form['date_fin_M'],$form['date_fin_D'],$form['date_fin_Y']);
if ($utsini > $utsfin) {
    $msg .='1+';
}
if ($utsexe < $utsfin) {
    $msg .='2+';
}
// fine controlli

if (isset($_POST['print']) && $msg=='') {
    $_SESSION['print_request']=array('script_name'=>'stampa_giomag',
                                     'ri'=>date("dmY",$utsini),
                                     'rf'=>date("dmY",$utsfin),
                                     'ds'=>date("dmY",$utsexe),
									 'md'=> $form['mode'],
									 'pr'=> $form['price'],
									 'sb'=> $form['subtitle']
                                     );
    header("Location: sent_print.php");
    exit;
}
if (isset($_POST['cover']) && $msg=='') {
    $_SESSION['print_request']=array('script_name'=>'stampa_cop_giomag',
                                     'ri'=>date("dmY",$utsini),
                                     'rf'=>date("dmY",$utsfin),
                                     'ds'=>date("dmY",$utsexe),
									 'sb'=> $form['subtitle']
                                     );
    header("Location: sent_print.php");
    exit;
}

require("../../library/include/header.php");
$script_transl=HeadMain(0,array('calendarpopup/CalendarPopup'));
echo "<script type=\"text/javascript\">
var cal = new CalendarPopup();
var calName = '';
function setMultipleValues(y,m,d) {
     document.getElementById(calName+'_Y').value=y;
     document.getElementById(calName+'_M').selectedIndex=m*1-1;
     document.getElementById(calName+'_D').selectedIndex=d*1-1;
}
function setDate(name) {
  calName = name.toString();
  var year = document.getElementById(calName+'_Y').value.toString();
  var month = document.getElementById(calName+'_M').value.toString();
  var day = document.getElementById(calName+'_D').value.toString();
  var mdy = month+'/'+day+'/'+year;
  cal.setReturnFunction('setMultipleValues');
  cal.showCalendar('anchor', mdy);
}
</script>
";
echo "<form method=\"POST\" name=\"select\">\n";
echo "<input type=\"hidden\" value=\"".$form['hidden_req']."\" name=\"hidden_req\" />\n";
echo "<input type=\"hidden\" value=\"".$form['ritorno']."\" name=\"ritorno\" />\n";
$gForm = new magazzForm();
echo "<div align=\"center\" class=\"FacetFormHeaderFont\">".$script_transl['title'];
echo "</div>\n";
echo "<table class=\"Tsmall\">\n";
if (!empty($msg)) {
    echo '<tr><td colspan="2" class="FacetDataTDred">'.$gForm->outputErrors($msg,$script_transl['errors'])."</td></tr>\n";
}
echo "<tr>\n";
echo "<td class=\"FacetFieldCaptionTD\">".$script_transl['date']."</td><td >\n";
$gForm->CalendarPopup('this_date',$form['this_date_D'],$form['this_date_M'],$form['this_date_Y'],'FacetSelect',1);
echo "</td></tr>\n";
echo "<tr><td class=\"FacetFieldCaptionTD\">".$script_transl['date_ini']."</td><td >\n";
$gForm->CalendarPopup('date_ini',$form['date_ini_D'],$form['date_ini_M'],$form['date_ini_Y'],'FacetSelect',1);
echo "</td></tr>\n";
echo "<tr>\n";
echo "<td class=\"FacetFieldCaptionTD\">".$script_transl['date_fin']."</td><td >\n";
$gForm->CalendarPopup('date_fin',$form['date_fin_D'],$form['date_fin_M'],$form['date_fin_Y'],'FacetSelect',1);
echo "</td></tr>\n";
echo "<tr>\n";
echo "<td class=\"FacetFieldCaptionTD\">" . $script_transl['mode'] . "</td>
<td >\n";
$gForm->variousSelect('mode', $script_transl['mode_value'], $form['mode'], 'FacetSelect', false, 'mode');
$gForm->variousSelect('price', $script_transl['price_value'], $form['price'], 'FacetSelect', false, 'price');
echo "</td>\n";
echo "</tr>\n";
echo "<tr><td class=\"FacetFieldCaptionTD\">".$script_transl['subtitle']."</td>
<td><input type=\"text\" name=\"subtitle\" value=\"" . $form['subtitle'] . "\" maxlength=\"40\"  /></td>
</tr>\n";
echo '<tr class="bg-info"><td class="text-center">';
echo '<input type="submit" class="btn btn-warning" name="cover" value="'.$script_transl['cover'].'"></td><td class="text-center">';
echo '<input  class="btn btn-info" type="submit" name="preview" value="'.$script_transl['view'].'" tabindex="100" >';
echo "</td></tr>";
echo "</table>\n";

$date_ini =  sprintf("%04d%02d%02d",$form['date_ini_Y'],$form['date_ini_M'],$form['date_ini_D']);
$date_fin =  sprintf("%04d%02d%02d",$form['date_fin_Y'],$form['date_fin_M'],$form['date_fin_D']);

if (isset($_POST['preview']) and $msg=='') {
  $m=getMovements($date_ini,$date_fin);
  echo "<div class=\"table-responsive\"><table class=\"Tlarge table table-striped table-bordered\">";
  if (sizeof($m) > 0) {
        $ctr_mv='';
        echo "<tr>";
        $linkHeaders=new linkHeaders($script_transl['header']);
        $linkHeaders->output();
        echo "</tr>";
        $sum=0.00;
		foreach ($m AS $key => $mv) {
			$datedoc = substr($mv['datdoc'],8,2).'-'.substr($mv['datdoc'],5,2).'-'.substr($mv['datdoc'],0,4);
			$datereg = substr($mv['datreg'],8,2).'-'.substr($mv['datreg'],5,2).'-'.substr($mv['datreg'],0,4);
			$movQuanti = $mv['quanti']*$mv['operat'];
			$sum += $movQuanti;
			$mv['descri']=(isset($mv['descri']))?$mv['descri']:'';
			echo "<tr><td>".$datereg." &nbsp;</td>";
			echo "<td align=\"center\">".$mv['caumag'].'-'.substr($mv['descri'],0,20)." &nbsp</td>";
			echo "<td>".substr($mv['desdoc'].' del '.$datedoc.' - '.$mv['ragsoc'],0,85)." &nbsp;</td>";
			echo "<td>".substr($mv['desart'],0,20)." &nbsp;</td>";
			echo "<td align=\"right\">".number_format($mv['prezzo'],$admin_aziend['decimal_price'],',','.')." &nbsp;</td>";
			echo "<td align=\"right\">".gaz_format_number(CalcolaImportoRigo($mv['quanti'],$mv['prezzo'],array($mv['scochi'],$mv['scorig'])))." &nbsp;</td>";
			echo "<td align=\"right\">".$mv['unimis']." &nbsp;</td>\n";
			echo "<td align=\"right\">".gaz_format_quantity($movQuanti,1,$admin_aziend['decimal_quantity'])." &nbsp;</td>\n";
			echo "</tr>\n";
			$ctr_mv = $mv['artico'];
		}
         echo "\t<tr class=\"FacetFieldCaptionTD\">\n";
         echo '<td colspan=8 class="FacetFooterTD text-center"><input type="submit" class="btn btn-warning" name="print" value="';
         echo $script_transl['print'];
         echo '">';
         echo "\t </td>\n";
         echo "\t </tr>\n";
  }
  echo "</table></div></form>";
}
?>
<?php
require("../../library/include/footer.php");
?>
