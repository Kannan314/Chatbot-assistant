<?php
require_once('../config.php');
Class Master extends DBConnection {
	private $settings;
	public function __construct(){
		global $_settings;
		$this->settings = $_settings;
		parent::__construct();
	}
	public function __destruct(){
		parent::__destruct();
	}
	
	public function save_response(){
		extract($_POST);
		if(!empty($id)){
			$del = $this->conn->query("DELETE FROM `questions` where id= '$id' ");
			if(!$del){
				return 2;
				exit;
			}
		}
		$data = "";
		$ins_resp = $this->conn->query("INSERT INTO `responses` set response_message = '{$response_message}' ");
		if(!$ins_resp){
			return 2;
			exit;
		}
		$resp_id = $this->conn->insert_id;

		foreach($question as $k => $v){
			$data = " response_id = {$resp_id} ";
			$data .= ", `question` = '$question[$k]' ";
			$ins[] = $this->conn->query("INSERT INTO `questions` set $data ");
		}
		if(isset($ins) && count($ins) == count($question)){
			$this->settings->set_flashdata("success"," Data successfully saved");
			return 1;
		}else{
			return 2;
			exit;
		}

	}
	public function delete_response(){
		extract($_POST);
		 $del = $this->conn->query("DELETE FROM `questions` where id = $id");
		 if($del){
			$this->settings->set_flashdata("success"," Data successfully deleted");
		 	return 1;
		 }else{
		 	$this->conn->error;
		 }
	}

	public function get_response(){
		extract($_POST);
		$message = str_replace(array("?"), '', $message);
		$not_question = array("what", "what is","who","who is", "where");
		if(in_array($message,$not_question)){
			$resp['status'] = "success";
			$resp['message'] = $this->settings->info('no_result');
			return json_encode($resp);
			exit;
		}
		$sql = "SELECT r.response_message,q.id from `questions` q inner join `responses` r on q.response_id = r.id where q.question Like '%{$message}%' ";
		$qry = $this->conn->query($sql);
		if($qry->num_rows > 0){
			$result = $qry->fetch_array();
			// var_dump($result);
			$resp['status'] = "success";
			$resp['message'] = $result['response_message'];
			$resp['sql'] = $sql;
			$this->conn->query("INSERT INTO `frequent_asks` set question_id = '{$result['id']}' ");
			return json_encode($resp);
		}else{
			$resp['status'] = "success";
			$resp['message'] = $this->settings->info('no_result');
			$chk = $this->conn->query("SELECT * FROM `unanswered` where `question` = '{$message}' ");
			if($chk->num_rows > 0){
				$this->conn->query("UPDATE `unanswered` set no_asks = no_asks + 1 ");
			}else{
				$this->conn->query("INSERT INTO `unanswered` set question = '{$message}' ");
			}
			return json_encode($resp);
		}
	}
	public function delete_unanswer(){
		extract($_POST);
		 $del = $this->conn->query("DELETE FROM `unanswered` where id = $id");
		 if($del){
			$this->settings->set_flashdata("success"," Data successfully deleted");
		 	return 1;
		 }else{
		 	$this->conn->error;
		 }
	}
}

$Master = new Master();
$action = !isset($_GET['f']) ? 'none' : strtolower($_GET['f']);
$sysset = new SystemSettings();
switch ($action) {
	case 'save_response':
		echo $Master->save_response();
	break;
	case 'delete_response':
		echo $Master->delete_response();
	break;
	case 'get_response':
		echo $Master->get_response();
	break;
	case 'delete_unanswer':
		echo $Master->delete_unanswer();
	break;
	default:
		// echo $sysset->index();
		break;
}