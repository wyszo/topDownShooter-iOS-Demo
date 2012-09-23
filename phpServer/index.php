<?php 

require_once 'db.php';


function prepare_database($db_scheme) {
	global $connection, $db_err;

	$create = "CREATE SCHEMA `LD20`;";
	mysql_query($create, $connection) or die($db_err);

	mysql_select_db($db_scheme, $connection) or die($db_err);

 	$create = "CREATE  TABLE `LD20`.`score` ( `ID` INT NOT NULL AUTO_INCREMENT, `NAME` VARCHAR(45) NULL, `SCORE` INT NULL, PRIMARY KEY (`ID`) );";
	mysql_query($create, $connection) or die($db_err);

	#echo 'created!';
}

function db_connect($host, $user, $pass, $db_scheme) {
	global $connection, $db_err;

	#echo 'db_connect\n';
	#echo $host.'\n'.$user.'\n'.$pass.'\n'.$db_scheme;

	$connection = mysql_connect($host, $user, $pass);
	if (!$connection) {
		die($db_err);
	}
	#echo 'connected';

	if (!mysql_select_db($db_scheme, $connection)) {
		prepare_database($db_scheme);
	}	
}

function db_disconnect() {
	global $connection;
	mysql_close($conenction);
}

function add_score_to_base($name, $score) {
	global $connection, $db_err;

	# ex: SELECT * FROM LD20.score WHERE name = "anonymous pilot" AND score = 30;
	$select = 'SELECT * FROM LD20.score WHERE name = "'.$name.'" AND score = '.$score.';';
	# echo $select;
	$result = mysql_query($select, $connection) or die ($db_err);
	
	if (!mysql_fetch_row($result) && $score != 0) {
		# ex: INSERT INTO LD20.score VALUES (NULL, 'test', 10);
		$insert = 'INSERT INTO LD20.score VALUES (NULL, "'.$name.'",'.$score.');';
		#echo $insert;

		mysql_query($insert, $connection) or die ($db_err);
	}
}

# n - number of records to print
function print_highscores_array($n) {
	global $connection, $db_err;

	if ($n == '') 
		$n = 5;

	# ex: SELECT * FROM LD20.score ORDER BY score DESC LIMIT 6;
	$select = 'SELECT * FROM LD20.score ORDER BY score DESC LIMIT '.$n;
	#echo $select;

	$result = mysql_query($select, $connection) or die ($db_err);

	while ($row = mysql_fetch_row($result)) {
		echo $row[1];
		echo ';;;';
		echo $row[2];
		echo ';;||;;';
	}
}

function check_input_correctness() {
  $name = $_GET['name'].$_POST['name']; 
  $score = $_GET['score'].$_POST['score'];  
	$highscore_list_len = $_GET['n'].$_POST['n'];
  $control_sum_acquired = $_GET['h'].$_POST['h'];  

  $salt = 'a dzwony bily wciaz...';
  $control_sum_calculated = md5($name.$score.$salt);

  if (strlen($control_sum_acquired) == 0 || strcmp($control_sum_acquired, $control_sum_calculated) != 0) 
  {
    # przesłana suma musi być wyliczona z konkatenacji imienia, wyniku i soli - musi się zgadzać z obliczoną po stronie serwera
    echo 'Error! probable game server attack attempt!';
    # echo $control_sum_calculated;
    exit(1);
  } 
  
	global $host, $user, $pass, $db_scheme;
	db_connect($host, $user, $pass, $db_scheme);

	add_score_to_base($name, $score);
	print_highscores_array($highscore_list_len); 

	db_disconnect();
}

check_input_correctness();

?>
