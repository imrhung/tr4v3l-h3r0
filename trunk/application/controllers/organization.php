<?php

defined('BASEPATH') OR exit('No direct script access allowed');

class Organization extends App_Controller {
    
    /*
     * Language variable: store the language option of site.
     */
    public $language;

    public function __construct() {
        parent::__construct();
        
        // Check if login
        if (!$this->session->userdata('islogin')){
            redirect('home/unauthorized');
        }
        if ($this->session->userdata('language') == 'vi'){
            $this->language = '_vi';
        } else {
            $this->language = '';
        }
    }

    public function index() {
        $this->page_title = 'Home';
        $this->current_section = 'home';
        $this->assets_css[] = "admin.css";
        $this->render_page('organization'.$this->language.'/index');
    }
    
    public function create_activity(){
        $this->page_title = 'Create an Activity';
        $this->current_section = 'activity';
        $this->assets_css[] = 'admin.css';
        $this->assets_css[] = 'datepicker/bootstrap-datetimepicker.min.css';
        $this->assets_js[] = 'organization/create_activity.js';
        $this->assets_js[] = 'datepicker/moment.js';
        $this->assets_js[] = 'datepicker/bootstrap-datetimepicker.min.js';
        $data['partnerId']= $this->session->userdata('partner_id');
        $this->render_page("organization".$this->language.'/create_activity', $data);
    }
    
    public function create_donation(){
        $this->page_title = 'Create a Donation';
        $this->current_section = 'donation';
        $this->assets_css[] = 'admin.css';
        $this->assets_js[] = 'organization/create_donation.js';
        $data['partnerId']= $this->session->userdata('partner_id');
        $this->render_page("organization".$this->language.'/create_donation', $data);
    }
    
    public function create_quiz(){
        $this->page_title = 'Create a Quiz';
        $this->current_section = 'quiz';
        $this->assets_css[] = 'admin.css';
        $this->assets_js[] = 'organization/create_quiz.js';
        $data['partnerId']= $this->session->userdata('partner_id');
        $this->render_page("organization".$this->language.'/create_quiz', $data);
    }
    
     public function under_construction(){
        $this->page_title = 'Under Construction';
        $this->current_section = 'construct';
        $this->assets_css[] = "admin.css";
        $this->render_page('home/under_construction');
    }
    
    public function help(){
        $this->page_title = 'Help';
        $this->current_section = 'help';
        $this->assets_css[] = "admin.css";
        $this->render_page('home/help');
    }
    
    public function lang($language){
        $sess_array = array(
            'language' => $language
        );
        $this->session->set_userdata($sess_array);
        //var_dump($this->session->all_userdata());
        redirect('organization');
    }
    
    
    public function questform(){
        $this->current_section = 'quest';
        $this->assets_js[] = "core.js";
        $this->render_page('organization/createquest');
    }
    
    public function partnerform(){
        $this->current_section = 'profile';
        $this->render_page('organization/partnerform');
    }
    
    public function questlist(){
        $this->page_title = 'Quests List';
        $this->assets_css[] = "simplePagination.css";
        $this->assets_css[] = "ngo.css";
        $this->assets_js[] = "vendor/jquery.simplePagination.js";
        $this->assets_js[] = "vendor/nhpopup.js";
        $this->current_section = 'quests';
        $this->render_page('organization/questlist');
    }
    
    
}