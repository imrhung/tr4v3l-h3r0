<?php

defined('BASEPATH') OR exit('No direct script access allowed');

class Partner extends App_Controller {

    function __construct() {
        parent::__construct();
        $this->load->model('partner_model');
    }

    /*     * ***SELECT**** */
    /* Last 18-March-2014 */

    public function getPartner() {
        $id = $this->input->post("id");

        // Initialization Array
        $result = array();
        $result['code'] = -1;
        $result['message'] = "";
        $result['info'] = array();

        $result['info']['partner'] = null;

        $resultCheck = $this->partner_model->getPartner($id);

        if ($resultCheck) {
            $result['code'] = 1;
            $result['message'] = "Success";
            $result['info']['partner'] = $resultCheck;
        } else {
            $result['code'] = 0;
            $result['message'] = "Fail";
            $result['info']['partner'] = $resultCheck;
        }

        echo json_encode($result);
    }

    /* Get Partner list function from database */

    public function getPartnerList() {
        $result = array();
        $result['code'] = -1;
        $result['message'] = "";
        $result['info'] = array();

        $result['info']['partners'] = "";

        $currentPage = $_POST['pageNumber'];
        $pageSize = $_POST['pageSize'];

        $resultCheck = $this->partner_model->getPartnerList($currentPage, $pageSize);

        if ($resultCheck) {
            $result['code'] = 1;
            $result['message'] = "Success";
            $result['info']['partners'] = $resultCheck;
        } else {
            $result['code'] = 0;
            $result['message'] = "Fail";
            $result['info']['partners'] = $resultCheck;
        }
        echo json_encode($result);
    }

    /* Update IsApproved function from Partner Table */

    // Last 18-March-2014
    public function updateIsApproved() {

        // Get infomation from user
        $Id = $this->input->post('id');
        $IsApproved = $this->input->post('is_approved');

        // Initialization notification Array
        $result = array();
        $result['code'] = -1;
        $result['message'] = "";

        // 	Update data
        $resultCheck = $this->partner_model->updateIsApproved($Id, (int) $IsApproved);

        //	Notification
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