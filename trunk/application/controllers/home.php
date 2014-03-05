<?php

defined('BASEPATH') OR exit('No direct script access allowed');

class Home extends App_Controller {

    public function __construct() {
        parent::__construct();
    }

    public function index() {
        if (isset($_GET['code'])){
            $this->facebook_ion_auth->login();
            if (!$this->ion_auth->logged_in()){
                redirect("user/loginfacebook", "refresh");
                exit();
            }
        }
        $this->body_class[] = 'home';
        $this->page_title = 'Welcome!';
        $this->current_section = 'home';
        $this->render_page('home/index');
    }

}