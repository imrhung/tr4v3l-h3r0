<?php
// Author: Hau
// Start date: 10-April-2014

defined('BASEPATH') OR exit('No direct script access allowed');

class Service extends App_Controller {
	function __construct() {
        parent::__construct();
        $this->load->model('service_model');
    }
	
	public function getTest() {
		$id = $this->input->post("id");
		
		// Initialization Array
        $result = array();
        $result['code'] = -1;
        $result['message'] = "";
        $result['info'] = array();

		$result['info']['activity'] = null;
		
		$resultCheck= $this->service_model->getTestById($id);
	
		if ($resultCheck) {
            $result['code'] = 1;
            $result['message'] = "Success";
            $result['info']['activity'] = $resultCheck;
        } else {
            $result['code'] = 0;
            $result['message'] = "Fail";
            $result['info']['activity'] = $resultCheck;
        }
		
		echo json_encode($result);
	}
	
	public function getPackets() {
		$pageSize = $this->input->post('pageSize');
		$rowIndex = $this->input->post('pageIndex');
	
		// Initialization Array
        $result = array();
        $result['code'] = -1;
        $result['message'] = "";
        $result['info'] = array();

		$result['info']['packet'] = null;
		
		$resultCheck= $this->service_model->getPacketsBy($rowIndex, $pageSize);
	
		if ($resultCheck) {
            $result['code'] = 1;
            $result['message'] = "Success";
            $result['info']['packet'] = $resultCheck;
        } else {
            $result['code'] = 0;
            $result['message'] = "Fail";
            $result['info']['packet'] = $resultCheck;
        }
		
		echo json_encode($result);
	}
	
	public function getQuizz() {
		// Initialization Array
        $result = array();
        $result['code'] = -1;
        $result['message'] = "";
        $result['info'] = array();

		$result['info']['quizz'] = null;
		
		$resultCheck= $this->service_model->getQuizzBy($id);
	
		if ($resultCheck) {
            $result['code'] = 1;
            $result['message'] = "Success";
            $result['info']['quizz'] = $resultCheck;
        } else {
            $result['code'] = 0;
            $result['message'] = "Fail";
            $result['info']['quizz'] = $resultCheck;
        }
		
		echo json_encode($result);
	}
	
	public function getUserProfile() {
		// Initialization Array
        $result = array();
        $result['code'] = -1;
        $result['message'] = "";
        $result['info'] = array();

		$result['info']['profile'] = null;
		
		$resultCheck= $this->service_model->getUserProfileBy($id);
	
		if ($resultCheck) {
            $result['code'] = 1;
            $result['message'] = "Success";
            $result['info']['profile'] = $resultCheck;
        } else {
            $result['code'] = 0;
            $result['message'] = "Fail";
            $result['info']['profile'] = $resultCheck;
        }
		
		echo json_encode($result);
	}
	
	public function getLeaderBoard() {
		// Initialization Array
        $result = array();
        $result['code'] = -1;
        $result['message'] = "";
        $result['info'] = array();

		$result['info']['leaderBoard'] = null;
		
		$resultCheck= $this->service_model->getLeaderBoardBy($id);
	
		if ($resultCheck) {
            $result['code'] = 1;
            $result['message'] = "Success";
            $result['info']['leaderBoard'] = $resultCheck;
        } else {
            $result['code'] = 0;
            $result['message'] = "Fail";
            $result['info']['leaderBoard'] = $resultCheck;
        }
		
		echo json_encode($result);
	}
	
	public function getUserAwards() {
		// Initialization Array
        $result = array();
        $result['code'] = -1;
        $result['message'] = "";
        $result['info'] = array();

		$result['info']['userAwards'] = null;
		
		$resultCheck= $this->service_model->getUserAwardsBy($id);
	
		if ($resultCheck) {
            $result['code'] = 1;
            $result['message'] = "Success";
            $result['info']['userAwards'] = $resultCheck;
        } else {
            $result['code'] = 0;
            $result['message'] = "Fail";
            $result['info']['userAwards'] = $resultCheck;
        }
		
		echo json_encode($result);
	}
	
	public function getActivities() {
		// Initialization Array
        $result = array();
        $result['code'] = -1;
        $result['message'] = "";
        $result['info'] = array();

		$result['info']['activity'] = null;
		
		$resultCheck= $this->service_model->getActivitiesBy($id);
	
		if ($resultCheck) {
            $result['code'] = 1;
            $result['message'] = "Success";
            $result['info']['activity'] = $resultCheck;
        } else {
            $result['code'] = 0;
            $result['message'] = "Fail";
            $result['info']['activity'] = $resultCheck;
        }
		
		echo json_encode($result);
	}
	
	public function getUserCurrentQuest() {
		// Initialization Array
        $result = array();
        $result['code'] = -1;
        $result['message'] = "";
        $result['info'] = array();

		$result['info']['currentQuest'] = null;
		
		$resultCheck= $this->service_model->getUserCurrentQuestBy($id);
	
		if ($resultCheck) {
            $result['code'] = 1;
            $result['message'] = "Success";
            $result['info']['currentQuest'] = $resultCheck;
        } else {
            $result['code'] = 0;
            $result['message'] = "Fail";
            $result['info']['currentQuest'] = $resultCheck;
        }
		
		echo json_encode($result);
	}
	
	public function getNumberOfChildren() {
		// Initialization Array
        $result = array();
        $result['code'] = -1;
        $result['message'] = "";
        $result['info'] = array();

		$result['info']['numberChildren'] = null;
		
		$resultCheck= $this->service_model->getNumberOfChildrenBy($id);
	
		if ($resultCheck) {
            $result['code'] = 1;
            $result['message'] = "Success";
            $result['info']['numberChildren'] = $resultCheck;
        } else {
            $result['code'] = 0;
            $result['message'] = "Fail";
            $result['info']['numberChildren'] = $resultCheck;
        }
		
		echo json_encode($result);
	}
	
	public function saveUserQuest() {
		// Input data
		$id = $this->input->post('id');
		
		// Initialization Array
        $result = array();
        $result['code'] = -1;
        $result['message'] = "";
		
		$resultCheck= $this->service_model->insertUserQuest($id);
	
		if ($resultCheck == 'Success') {
            $result['code'] = 1;
            $result['message'] = "Success";
        } else {
            $result['code'] = 0;
            $result['message'] = "Fail";
        }
		
		echo json_encode($result);
	}
	
	public function registerUserFb() {
		// Input data
		$fullName = $this->input->post('fullName');
		$email = $this->input->post('email');
		$phone = $this->input->post('phone');
		$facebookId = $this->input->post('facebookId');
		
		// Initialization Array
        //$result;
		
		$resultCheck= $this->service_model->insertUserFb($fullName,$email,$phone,$facebookId);
		//$result = $resultCheck;
		
		/*
		if ($resultCheck) {
            $result['code'] = 1;
            $result['message'] = "Success";
			$result['info'] = $resultCheck;
        } else {
            $result['code'] = 0;
            $result['message'] = "Fail";
        }
		*/
		echo json_encode($resultCheck);
	}
	
	public function spentPointDonation() {
		
	}
	
	public function spentPointActivity() {
		
	}
}