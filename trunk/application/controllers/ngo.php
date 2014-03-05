<?php

defined('BASEPATH') OR exit('No direct script access allowed');

class Ngo extends App_Controller {

    function __construct() {
        parent::__construct();
        
        $this->load->library('ion_auth');
        $this->load->library('form_validation');
        $this->load->helper('url');
        $this->load->helper('html');

        // Load MongoDB library instead of native db driver if required
        $this->config->item('use_mongodb', 'ion_auth') ?
                        $this->load->library('mongo_db') :
                        $this->load->database();

        $this->form_validation->set_error_delimiters($this->config->item('error_start_delimiter', 'ion_auth'), $this->config->item('error_end_delimiter', 'ion_auth'));

        $this->lang->load('auth');
        $this->load->helper('language');
    }

    function index() {
        $this->page_title = 'Quests List';
        $this->assets_css[] = "simplePagination.css";
        $this->assets_css[] = "ngo.css";
        $this->assets_js[] = "vendor/jquery.simplePagination.js";
        $this->assets_js[] = "vendor/nhpopup.js";
        $this->render_page('ngo/index');
    }

    /* 10 Oct 2013 */
    public function signinWithEmailInfo() {
        //http://localhost:1337/travelhero/user/signinWithEmailInfo
        $result = array();
        $result['code'] = 0;
        $result['message'] = "";
        $result['info'] = null;

        $username = $_POST['username'];
        $password = $_POST['password'];

        $resultCheck = $this->model->getUserDataWithEmail($username, $password);
        if ($resultCheck) {
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

    public function signinWithFacebookInfo() {
        //http://localhost:1337/travelhero/user/signinWithFacebookInfo
        $result = array();
        $result['code'] = 0;
        $result['message'] = "";
        $result['info'] = null;

        $facebookId = $_POST['facebookId'];

        $resultCheck = $this->model->getUserDataWithFacebookId
                ($facebookId);
        if ($resultCheck) {
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

    /* 10 Oct 2013 */

    public function signupWithEmailInfo() {
        //http://localhost:1337/travelhero/user/signupWithEmailInfo
		
        $result = array();
        $result['code'] = -1;
        $result['message'] = "";
		$result['info'] = null;
		
        $fullName = $_POST['fullName'];
        $heroName = $_POST['heroName'];
        $email = $_POST['email'];
        $phone = $_POST['phone'];
        $password = $_POST['password'];
		
        $resultCheck = $this->model->checkInfoExistsWithEmail($fullName, $heroName, $email, $phone, $password);
		
        if ($resultCheck->id == -1) {
            // Email already exists
            $result['code'] = 0;
            $result['message'] = "Email already exists";
			$result['info'] = null;
        } else {
            // Success
            $result['code'] = 1;
            $result['message'] = "Sign up successful";
			$result['info'] = $resultCheck;
        }

        echo json_encode($result);
    }

    /* Last Edit 17-Oct-2013 */

    public function signupWithFacebookInfo() {
        //http://localhost:1337/travelhero/user/signupWithFacebookInfo
		
        $result = array();
        $result['code'] = -1;
        $result['message'] = '';
        $result['info'] = null;

        $facebookId = $_POST['facebookId'];
        $fullName = $_POST['fullName'];
		$heroName = $_POST['heroName'];
		$email = $_POST['email'];

        $resultCheck = $this->model->checkInfoExistsWithFacebookId($facebookId, $fullName, $heroName, $email);
		
        if ($resultCheck->code == 1) {
            // Not Exists -> sign up success
			$result['code'] = 1;
			$result['message'] = "Sign up success";
			$result['info'] = $resultCheck;
			
        } else {
            // Already -> sign up fail
            $result['code'] = 0;
            $result['message'] = "Already";
            $result['info'] = $resultCheck;
        }
		
        echo json_encode($result);
    }

    /* Last Edit 12 Oct 2013 */

    public function hotelAgodaInfo() {
        //http://localhost:1337/travelhero/user/hotelAgodaInfo
        $result = array();
        $result['code'] = -1;
        $result['message'] = "";
        $result['info'] = null;

        $currentPage = $_POST['currentPage'];
        $pageSize = $_POST['pageSize'];
		$lat = $_POST['lat'];
		$lon = $_POST['lon'];
		$distance = $_POST['distance'];
		$countryisocode = $_POST['countryisocode'];

        $resultCheck = $this->model->getHotelAgodaData($currentPage, $pageSize, $lat, $lon, $distance, $countryisocode);

        if ($resultCheck) {
            $result['code'] = 1;
            $result['message'] = "Get Hotel Agoda Success";
            $result['info'] = $resultCheck;
        } else {
            $result['code'] = 0;
            $result['message'] = "Get Hotel Agoda Fail";
            $result['info'] = $resultCheck;
        }
        echo json_encode($result);
    }

    /* Leader board Last Edit 22-Oct-2013 */
	
	public function leaderBoard() {
		//http://localhost:1337/travelhero/user/leaderBoard
		$result = array();
		$result['code'] = -1;
		$result['message'] = '';
		$result['info'] = null;
		
		$data = $this->model->getLeaderBoard();
		
		if ($data) {
			$result['code'] = 1;
			$result['message'] = 'Success';
			$result['info'] = $data;
		} else {
			$result['code'] = 0;
			$result['message'] = 'Fail';
			$result['info'] = null;
		}
		
		echo json_encode($result);
	}

	/* Sigup for WordPress 25-Oct-2013 */
	
	public function signupWebUser() {
		$result = array();
        $result['code'] = -1;
        $result['message'] = '';
        // $result['info'] = null;

        $facebookId = $_POST['facebookId'];
        $fullName = $_POST['fullName'];
		$heroName = $_POST['heroName'];

        $resultCheck = $this->model->checkInfoExistsWithFacebookId($facebookId, $fullName, $heroName);
		
        if ($resultCheck->code == 1) {
            // Not Exists -> sign up success
			$result['code'] = 1;
			$result['message'] = "Sign up success";
			// $result['info'] = $resultCheck;
			
        } else {
            // Already -> sign up fail
            $result['code'] = 0;
            $result['message'] = "Email or Hero Name Already. Please choose another Email or Hero Name.";
            // $result['info'] = $resultCheck;
        }
		
        return json_encode($result);
	}
	
	/* Test check fields is empty 4 Dec 2013 */

    public function signupWithEmailInfoTest() {
        //http://localhost:1337/travelhero/user/signupWithEmailInfoTest
		
        $result = array();
        $result['code'] = -1;
        $result['message'] = "";
		$result['info'] = null;
		
        $fullName = $_POST['fullName'];
        $heroName = $_POST['heroName'];
        $email = $_POST['email'];
        $phone = $_POST['phone'];
        $password = $_POST['password'];
		
		if(empty($fullName) || empty($heroName) || empty($email) || empty($password)) {
			// Email already exists
			$result['code'] = 2;
			$result['message'] = "Invalid information";
			$result['info'] = null;
			
		} else {
			$resultCheck = $this->model->checkInfoExistsWithEmail($fullName, $heroName, $email, $phone, $password);
			
			if ($resultCheck->id == -1) {
				// Email already exists
				$result['code'] = 0;
				$result['message'] = "Email already exists";
				$result['info'] = null;
			} else {
				// Success
				$result['code'] = 1;
				$result['message'] = "Sign up successful";
				$result['info'] = $resultCheck;
			}
		}
		
        echo json_encode($result);
    }
}


















