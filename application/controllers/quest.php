<?php

defined('BASEPATH') OR exit('No direct script access allowed');

class Quest extends App_Controller {

    function __construct() {
        parent::__construct();
        $this->load->library('ion_auth');
        $this->load->library('form_validation');
        $this->load->helper('url');
        $this->load->helper('html');
        $this->load->model('quest_model');

        // Load MongoDB library instead of native db driver if required
        $this->config->item('use_mongodb', 'ion_auth') ?
                        $this->load->library('mongo_db') :
                        $this->load->database();

        $this->form_validation->set_error_delimiters($this->config->item('error_start_delimiter', 'ion_auth'), $this->config->item('error_end_delimiter', 'ion_auth'));

        $this->lang->load('auth');
        $this->load->helper('language');
    }

    function index() {
        $this->page_title = 'Quest';
        $this->render_page('quest/index');
    }
    
    // For the display of an quest detail
    public function detail($id) {
        $this->page_title = 'Quest Detail';
        $this->assets_css[] = "quest.css";
        $data['questId'] = $id;
        // call View
        $this->render_page('quest/detail', $data);
    }
    
    // Edit one quest
    public function edit($id) {
        $this->page_title = 'Edit Quest';
        $this->assets_css[] = "quest.css";
        $data['questId'] = $id;
        // call View
        $this->render_page('quest/edit', $data);
    }

    /* Last Edit 17 Oct 2013 */

    public function questInfo() {
        //http://localhost:1337/travelhero/user/questInfo
        $result = array();
        $result['code'] = -1;
        $result['message'] = "";
        $result['info'] = null;

        $currentPage = $_POST['currentPage'];
        $pageSize = $_POST['pageSize'];

        $resultCheck = $this->quest_model->getQuestData($currentPage, $pageSize);
        
        if ($resultCheck) {
            $result['code'] = 1;
            $result['message'] = "Get Quest Success";
            $result['info'] = $resultCheck;
        } else {
            $result['code'] = 0;
            $result['message'] = "Get Quest Fail";
            $result['info'] = $resultCheck;
        }
        echo json_encode($result);
    }

    /* Last Edit 15-Oct-2013 */

    public function questQRCodeInfo() {
        $questId = $_POST['questId'];
        $result = $this->quest_model->getSpecialQuestData($questId);
        if ($result) {
            $qrCodeInfo = base64_encode(json_encode($result));
            $url = 'https://chart.googleapis.com/chart?cht=qr&chs=300x300&chl=' . $qrCodeInfo;
            echo '<img src="' . $url . '" />';
        } else {
            echo 'Error';
        }
    }

    /*
      Last Edit 17-Oct-2013
     */

    public function relatedQuest() {
        $questId = $_POST['questId'];

        $data = array();
        $data['code'] = -1;
        $data['message'] = '';
        $data['info'] = null;

        $result = $this->quest_model->getQuestReferData($questId);
        if ($result) {
            $data['code'] = 1;
            $data['message'] = 'Success';
            $data['info'] = $result;
        } else {
            $data['code'] = 0;
            $data['message'] = 'Fail';
            $data['info'] = null;
        }
        echo json_encode($data);
    }

    /* Last Edit 18-Oct-2013 */

    public function acceptQuest() {
        $data = array();
        $data['code'] = -1;
        $data['message'] = '';

        $userId = $_POST['userId'];
        $questId = $_POST['questId'];
        $parentQuestId = $_POST['parentQuestId'];

        $result = $this->quest_model->updateAcceptQuest($userId, $questId, $parentQuestId);

        if ($result[0] == 1) {
            $data['code'] = 1;
            $data['message'] = 'True';
        } else if ($resutl[0] == 0) {
            $data['code'] = 0;
            $data['message'] = 'False';
        }

        echo json_encode($data);
    }

    /* Last Edit 21-Oct-2013 */

    public function completeQuest() {
        $userId = $_POST['userId'];
        $questId = $_POST['questId'];

        $result = $this->quest_model->updateStatus($userId, $questId);

        echo json_encode($result);
    }

    public function allAcceptQuestOfUser() {
        $data = array();
        $data['code'] = -1;
        $data['message'] = '';
        $data['info'] = null;

        $userId = $_POST['userId'];
        $result = $this->quest_model->getAcceptQuestOfUser($userId);

        if ($result != null) {
            $data['code'] = 1;
            $data['message'] = 'Success';
            $data['info'] = $result;
        } else {
            $data['code'] = 0;
            $data['message'] = 'Fail';
            $data['info'] = null;
        }
        echo json_encode($data);
    }
    
    // Function to get list of quests by one parner- NGO
    public function questListInfobyUser() {
        //http://localhost:1337/travelhero/quest/questListInfobyUser
        $result = array();
        $result['code'] = -1;
        $result['message'] = "";
        $result['info'] = null;

        $currentPage = $_POST['currentPage'];
        $pageSize = $_POST['pageSize'];
        $userId = $_POST['userId'];

        $resultCheck = $this->quest_model->getQuestDatabyUser($currentPage, $pageSize, $userId);

        if ($resultCheck) {
            $result['code'] = 1;
            $result['message'] = "Get Quest Success";
            $result['info'] = $resultCheck;
        } else {
            $result['code'] = 0;
            $result['message'] = "Get Quest Fail";
            $result['info'] = $resultCheck;
        }
        echo json_encode($result);
    }
    
    // Function to get number of quests by one parner- NGO
    public function questCountbyUser() {
        //http://localhost:1337/travelhero/quest/questListInfobyUser
        $result = array();
        $result['code'] = -1;
        $result['message'] = "";
        $result['info'] = null;

        $userId = $_POST['userId'];
        
        $resultCheck = $this->quest_model->getQuestCountbyUser($userId);

        if ($resultCheck) {
            $result['code'] = 1;
            $result['message'] = "Get Quest Success";
            $result['info'] = (int) $resultCheck[0]->{"COUNT(*)"};
        } else {
            $result['code'] = 0;
            $result['message'] = "Get Quest Fail";
            $result['info'] = $resultCheck;
        }
        echo json_encode($result);
    }

    // Function to get list of quests by one parner- NGO
    public function questDetail() {
        //http://localhost:1337/travelhero/quest/questListInfobyUser
        $result = array();
        $result['code'] = -1;
        $result['message'] = "";
        $result['info'] = null;

        $questId = $_POST['questId'];

        $resultCheck = $this->quest_model->getQuestDetail($questId);

        if ($resultCheck) {
            $result['code'] = 1;
            $result['message'] = "Get Quest Success";
            $result['info'] = $resultCheck;
        } else {
            $result['code'] = 0;
            $result['message'] = "Get Quest Fail";
            $result['info'] = $resultCheck;
        }
        echo json_encode($result);
    }
    
    public function updateQuestState() {
        $state = $_POST['state'];
        $questId = $_POST['questId'];
        
        $result = array();
        $result['code'] = -1;
        $result['message'] = "";
        $result['info'] = null;

        $resultCheck = $this->quest_model->updateQuestState($questId, $state);

        if ($resultCheck) {
            $result['code'] = 1;
            $result['message'] = "Get Quest Success";
            $result['info'] = $resultCheck;
        } else {
            $result['code'] = 0;
            $result['message'] = "Get Quest Fail";
            $result['info'] = $resultCheck;
        }
        echo json_encode($result);
    }
}

