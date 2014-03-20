<?php
			/* Tan - Last 13-March-2014*/
				
defined('BASEPATH') OR exit('No direct script access allowed');

	class VirtualQuest extends App_Controller{

		 function __construct() {
			parent::__construct();
			$this->load->library('ion_auth');
			$this->load->library('form_validation');
			$this->load->helper('url');
			$this->load->helper('html');
			$this->load->model('virtualquest_model');

			/* Load MongoDB library instead of native db driver if required */
			$this->config->item('use_mongodb', 'ion_auth') ?
							$this->load->library('mongo_db') :
							$this->load->database();

			$this->form_validation->set_error_delimiters($this->config->item('error_start_delimiter', 'ion_auth'),
														$this->config->item('error_end_delimiter', 'ion_auth'));

			$this->lang->load('auth');
			$this->load->helper('language');
		}
								/*****SELECT*****/
							/* Last 18-March-2014 */
		/* Get a VirtualQuest function from database*/
		public function getVirtualQuest(){
			$result = array();
			$result['code'] = -1;
			$result['message'] = "";
			$result['info'] = null;
		
			
			// $result['info']['condition'] = "";
			
			$id = $_POST['id'];

			$VirtualQuestValues = array();
			// $QuestConditionValues = $this->virtualquest_model->getQuestCondition($id);
			$VirtualQuestValues = $this->virtualquest_model->getVirtualQuest($id);
			if ($VirtualQuestValues) {
				$result['code'] = 1;
				$result['message'] = "Success";
				$result['info'] = $VirtualQuestValues;
				// $result['info']['condition'] = $QuestConditionValues;
			} else {
				$result['code'] = 0;
				$result['message'] = "Fail";
				$result['info'] = $VirtualQuestValues;
				// $result['info']['condition'] = $QuestConditionValues;
			}
			echo json_encode($result);
		}
		
		/* Get VirtualQuest list function from database*/
		public function getVirtualQuestList(){
			$result = array();
			$result['code'] = -1;
			$result['message'] = "";
			$result['info'] = array();
		
			$result['info']['quest'] = "";
			$currentPage = $_POST['pageNumber'];
			$pageSize = $_POST['pageSize'];

			$resultCheck = $this->virtualquest_model->getVirtualQuestList($currentPage, $pageSize);
			
			if ($resultCheck) {
				$result['code'] = 1;
				$result['message'] = "Success";
				$result['info']['quest'] = $resultCheck;
			} else {
				$result['code'] = 0;
				$result['message'] = "Fail";
				$result['info']['quest'] = $resultCheck;
			}
			echo json_encode($result);
		}
		
								/*****INSERT*****/
	/* Insert a new virtualquest function into databases */
	public function insertVirtualQuest(){
				
		// Get infomation from user      
        $partnerId = $this->input->post('partner_id');
		$packetId = $this->input->post('packet_id');
        $name = $this->input->post('name');
		$point = $this->input->post('point');
        $activity_id_1 = $this->input->post('activity_id_1');
		$activity_id_2 = $this->input->post('activity_id_2');
        $activity_id_3 = $this->input->post('activity_id_3');
		$donation_id_1 = $this->input->post('donation_id_1');
        $donation_id_2 = $this->input->post('donation_id_2');
		$donation_id_3 = $this->input->post('donation_id_3');       
		
		// Initialization Array
        $result = array();
        $result['code'] = -1;
        $result['message'] = "";
							
		// Insert Quiz
        $resultCheck = $this->virtualquest_model->insertVirtualQuest($partnerId, $packetId, $name, $point);
		
		// Insert ConditionQuest activity action
		if($activity_id_1 != 0)
			$this->virtualquest_model->insertConditionQuest(1, $activity_id_1);	
		if($activity_id_2 != 0)
			$this->virtualquest_model->insertConditionQuest(1, $activity_id_2);	
		if($activity_id_3 != 0)
			$this->virtualquest_model->insertConditionQuest(1, $activity_id_3);				
		
		// Insert ConditionQuest activity action
		if($donation_id_1 != 0)
			$this->virtualquest_model->insertConditionQuest(2, $activity_id_1);	
		if($donation_id_2 != 0)
			$this->virtualquest_model->insertConditionQuest(2, $donation_id_2);	
		if($donation_id_3 != 0)
			$this->virtualquest_model->insertConditionQuest(2, $donation_id_3);	
			
        if ($resultCheck == 'Success') {
            $result['code'] = 1;
            $result['message'] = "Success";
        } else{
            $result['code'] = 0;
            $result['message'] = "Fail";
        }
        echo json_encode($result);
	}
								/****DELETE****/
							/* Last 12-March-2014 */
		/* Delete virtualquest function */
		public function deleteVirtualQuest(){
			$result = array();
			$result['code'] = -1;
			$result['message'] = "";

			$id = $_POST['id'];

			$resultCheck = $this->virtualquest_model->deleteVirtualQuest($id);
			
			if ($resultCheck == 'Success') {
				$result['code'] = 1;
				$result['message'] = "Success";			
			} else {
				$result['code'] = 0;
				$result['message'] = "Fail";			
			}
			echo json_encode($result);
		}
	}
?>