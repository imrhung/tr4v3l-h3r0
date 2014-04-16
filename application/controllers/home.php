<?php

defined('BASEPATH') OR exit('No direct script access allowed');

class Home extends App_Controller {

    public function __construct() {
        parent::__construct();
        
    }

    public function index() {
        // Check if login
        if ($this->session->userdata('islogin')){
            if ($this->session->userdata('role') == 'admin'){
                redirect('admin');
            } else if ($this->session->userdata('role') == 'organization'){
                redirect('organization');
            }
        }
        redirect('login');
    }
    
    public function unauthorized(){
        $this->load->view('home/unauthorized');
    }
    
    public function not_approved(){
        $this->load->view('home/not_approved');
    }
    
    public function lang($language){
        $sess_array = array(
            'language' => $language
        );
        $this->session->set_userdata($sess_array);
        //var_dump($this->session->all_userdata());
        
        // Get parametter to redirect page
        $redirectUrl = $this->input->get('redirect');
        redirect($redirectUrl);
    }

}