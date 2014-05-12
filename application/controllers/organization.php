<?php

defined('BASEPATH') OR exit('No direct script access allowed');

class Organization extends App_Controller {
    
    /*
     * Language variable: store the language option of site.
     */
    public $language;
    
    private $data = array();

    public function __construct() {
        parent::__construct();
        $this->load->model('organization_model');
        $this->load->model('partner_model');
        
        // Check if login
        if (!$this->session->userdata('islogin')){
            redirect('home/unauthorized');
        }
        
        // Check user approval.
        /* Not in use
        $partnerId = $this->session->userdata('partner_id');
        if ( ! $this->organization_model->checkUserApprove($partnerId)){
            redirect('home/not_approved');
        }
         */
        
        // Set language
        if ($this->session->userdata('language') == 'en'){
            $this->language = '';
        } else {
            $this->language = '_vi';
        }
        
        // Setup common data for pages:
        $this->data['partnerId']= $this->session->userdata('partner_id');
        $partner = $this->partner_model->getPartnerTable($this->data['partnerId']);
        $this->data['logo_url'] = $partner->{'LogoURL'} ?  $partner->{'LogoURL'}: site_url('assets/img/ngo_logo.jpg');
    }

    public function index() {
        $this->page_title = 'Home';
        $this->current_section = 'home';
        $this->assets_css[] = "admin.css";
        $this->render_page('organization'.$this->language.'/index', $this->data);
    }
    
    public function create_activity(){
        $this->page_title = 'Create an Activity';
        $this->current_section = 'activity';
        $this->assets_css[] = 'admin.css';
        $this->assets_css[] = 'datepicker/bootstrap-datetimepicker.min.css';
        $this->assets_js[] = 'organization/create_activity.js';
        $this->assets_js[] = 'datepicker/moment.js';
        $this->assets_js[] = 'datepicker/bootstrap-datetimepicker.min.js';
        $this->data['partnerId']= $this->session->userdata('partner_id');
        $this->render_page("organization".$this->language.'/create_activity', $this->data);
    }
    
    public function create_donation(){
        $this->page_title = 'Create a Donation';
        $this->current_section = 'donation';
        $this->assets_css[] = 'admin.css';
        $this->assets_js[] = 'organization/create_donation.js';
        $this->data['partnerId']= $this->session->userdata('partner_id');
        $this->render_page("organization".$this->language.'/create_donation', $this->data);
    }
    
    public function create_quiz(){
        $this->page_title = 'Create a Quiz';
        $this->current_section = 'quiz';
        $this->assets_css[] = 'admin.css';
        $this->assets_js[] = 'organization/create_quiz.js';
        $this->data['partnerId']= $this->session->userdata('partner_id');
        $this->render_page("organization".$this->language.'/create_quiz', $this->data);
    }
    
     public function under_construction(){
        $this->page_title = 'Under Construction';
        $this->current_section = 'construct';
        $this->assets_css[] = "admin.css";
        $this->render_page('home/under_construction', $this->data);
    }
    
    public function help(){
        $this->page_title = 'Help';
        $this->current_section = 'help';
        $this->assets_css[] = "admin.css";
        $this->render_page('home/help', $this->data);
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