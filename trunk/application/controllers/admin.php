<?php

defined('BASEPATH') OR exit('No direct script access allowed');

class Admin extends App_Controller {

    public function __construct() {
        parent::__construct();
    }

    public function index() {
        $this->current_section = 'home';
        $this->assets_css[] = "admin.css";
        $this->render_page_admin('admin/index');
    }
    
    public function edit_quiz($id = NULl){
        if ($id == NULL) {
            redirect("admin/index");
        } else {
            $this->current_section = "edit_quiz";
            $this->assets_css[] = "admin.css";
            $data = array(
                'quizId' => $id,
            );
            $this->render_page_admin('admin/edit_quiz', $data);
        }
    }
    
    public function create_quest(){
        $this->current_section = 'create_quest';
        $this->assets_css[] = "admin.css";
        $this->render_page_admin('admin/create_quest');
    }
    
    public function questform(){
        $this->current_section = 'quest';
        $this->assets_js[] = "core.js";
        $this->render_page_admin('admin/createquest');
    }
    
    public function partnerform(){
        $this->current_section = 'profile';
        $this->render_page_admin('admin/partnerform');
    }
    
    public function questlist(){
        $this->page_title = 'Quests List';
        $this->assets_css[] = "simplePagination.css";
        $this->assets_css[] = "ngo.css";
        $this->assets_js[] = "vendor/jquery.simplePagination.js";
        $this->assets_js[] = "vendor/nhpopup.js";
        $this->current_section = 'quests';
        $this->render_page_admin('admin/questlist');
    }
}