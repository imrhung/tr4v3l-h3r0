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

}