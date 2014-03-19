<?php
			/* Tan - Last 13-March-2014*/
				
defined('BASEPATH') OR exit('No direct script access allowed');

class Packet extends App_Controller{

	 function __construct() {
        parent::__construct();
        $this->load->library('ion_auth');
        $this->load->library('form_validation');
        $this->load->helper('url');
        $this->load->helper('html');
        $this->load->model('packet_model');

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
					
	/* Get Packet list function from database*/
	public function getPacketList(){
		$result = array();
        $result['code'] = -1;
        $result['message'] = "";
        $result['info'] = null;

        $currentPage = $_POST['pageNumber'];
        $pageSize = $_POST['pageSize'];

        $resultCheck = $this->packet_model->getPacketList($currentPage, $pageSize);
        
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
	
						/*****INSERT*****/
					/* Last 18-March-2014 */
	/*	Packet insert function*/
	public function insertPacket(){
		$title 		 = $this->input->post('title');
		$imageUrl	 = $this->input->post('image_url'); 
		$partner_id  = $this->input->post('partner_id');		
		
		// Initialization Array
        $result = array();
        $result['code'] = -1;
        $result['message'] = "";
		
		// Implements work
		$resultCheck = $this->packet_model->insertPacket($title, $imageUrl, $partner_id);
		
		if ($resultCheck == 'Success') {
            $result['code'] = 1;
            $result['message'] = "Success";
        } else{
            $result['code'] = 0;
            $result['message'] = "Fail";
        }
        echo json_encode($result);
	}
}
?>