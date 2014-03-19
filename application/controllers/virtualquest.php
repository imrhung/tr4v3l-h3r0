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
		/* Get VirtualQuest list function from database*/
		public function getVirtualQuest(){
			$result = array();
			$result['code'] = -1;
			$result['message'] = "";
			$result['info'] = null;

			$id = $_POST['id'];

			$resultCheck = $this->virtualquest_model->getVirtualQuest($id);
			
			if ($resultCheck == 'Success') {
				$result['code'] = 1;
				$result['message'] = "Success";
				$result['info'] = $resultCheck;
			} else {
				$result['code'] = 0;
				$result['message'] = "Fail";
				$result['info'] = $resultCheck;
			}
			echo json_encode($result);
		}
		
		/* Get VirtualQuest list function from database*/
		public function getVirtualQuestList(){
			$result = array();
			$result['code'] = -1;
			$result['message'] = "";
			$result['info'] = null;

			$currentPage = $_POST['pageNumber'];
			$pageSize = $_POST['pageSize'];

			$resultCheck = $this->virtualquest_model->getVirtualQuestList($currentPage, $pageSize);
			
			if ($resultCheck == 'Success') {
				$result['code'] = 1;
				$result['message'] = "Success";
				$result['info'] = $resultCheck;
			} else {
				$result['code'] = 0;
				$result['message'] = "Fail";
				$result['info'] = $resultCheck;
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