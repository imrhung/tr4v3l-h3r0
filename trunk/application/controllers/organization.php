<?php

defined('BASEPATH') OR exit('No direct script access allowed');

class Organization extends App_Controller {

    public function __construct() {
        parent::__construct();
    }

    public function index() {
        $this->current_section = 'home';
        $this->assets_css[] = "admin.css";
        $this->render_page('organization/index');
    }
    
    public function create_activity(){
        $this->current_section = 'activity';
        $this->assets_css[] = 'admin.css';
        $this->assets_css[] = 'datepicker/bootstrap-datetimepicker.min.css';
        $this->assets_css[] = 'hero.css';
        $this->assets_js[] = 'organization/create_activity.js';
        $this->assets_js[] = 'datepicker/moment.js';
        $this->assets_js[] = 'datepicker/bootstrap-datetimepicker.min.js';
        $this->render_page("organization/create_activity");
    }
    
    public function create_donation(){
        $this->current_section = 'donation';
        $this->assets_css[] = 'admin.css';
        $this->render_page("organization/create_donation");
    }
    
    public function create_quiz(){
        $this->current_section = 'quiz';
        $this->assets_css[] = 'admin.css';
        $this->render_page("organization/create_quiz");
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