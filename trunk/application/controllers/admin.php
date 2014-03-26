<?php

defined('BASEPATH') OR exit('No direct script access allowed');

class Admin extends App_Controller {

    public function __construct() {
        parent::__construct();
        
        // Check if login
        if ($this->session->userdata('islogin')){
            if ($this->session->userdata('role') == 'admin'){
                //redirect('admin');
            } else if ($this->session->userdata('role') == 'organization'){
                //redirect('organization');
                //$this->load->view('home/unauthorized');
                redirect('home/unauthorized');
            }
        }
        
    }

    public function index() {
        $this->current_section = 'home';
        $this->assets_css[] = "admin.css";
        $this->assets_css[] = 'datatables/jquery.dataTables.css';
        $this->assets_css[] = 'datatables/data-bootstrap.css';
        $this->assets_js[] = 'datatables/jquery.dataTables.js';
        $this->assets_js[] = 'datatables/pagebootstrap.js';
        $this->assets_js[] = 'admin/index.js';
        $this->assets_js[] = 'bootbox/bootbox.min.js';
        $this->render_page_admin('admin/index');
    }
    
    public function edit_quiz($id = NULL){
        if ($id == NULL) {
            redirect("admin/index");
        } else {
            $this->current_section = "edit_quiz";
            $this->assets_css[] = "admin.css";
            $this->assets_js[] = 'admin/edit_quiz.js';
            $this->assets_js[] = 'bootbox/bootbox.min.js';
            $data = array(
                'quizId' => $id,
            );
            $this->render_page_admin('admin/edit_quiz', $data);
        }
    }
    
    public function edit_activity($id=NULL){
        if ($id == NULL){
            redirect("admin/index");
        } else {
            $this->current_section = "edit_quiz";
            $this->assets_css[] = "admin.css";
            $this->assets_css[] = 'datepicker/bootstrap-datetimepicker.min.css';
            $this->assets_js[] = 'admin/edit_activity.js';
            $this->assets_js[] = 'bootbox/bootbox.min.js';
            $this->assets_js[] = 'datepicker/moment.js';
            $this->assets_js[] = 'datepicker/bootstrap-datetimepicker.min.js';
            
            $data = array(
                'activityId' => $id
            );
            $this->render_page_admin('admin/edit_activity', $data);
        }
    }
    
    public function edit_donation($id=NULL){
        if ($id == NULL){
            redirect("admin/index");
        } else {
            $this->current_section = "edit_donation";
            $this->assets_css[] = "admin.css";
            $this->assets_js[] = 'admin/edit_donation.js';
            $this->assets_js[] = 'bootbox/bootbox.min.js';
            
            $data = array(
                'donationId' => $id
            );
            $this->render_page_admin('admin/edit_donation', $data);
        }
    }
    
    public function edit_quest($id=NULL){
        if ($id == NULL){
            redirect("admin/index");
        } else {
            $this->current_section = "edit_quest";
            $this->assets_css[] = "admin.css";
            $this->assets_js[] = 'admin/edit_quest.js';
            $this->assets_js[] = 'bootbox/bootbox.min.js';
            
            $data = array(
                'questId' => $id
            );
            $this->render_page_admin('admin/edit_quest', $data);
        }
    }
    
    public function create_quest(){
        
        $this->current_section = 'create_quest';
        $this->assets_js[] = 'admin/create_quest.js';
        $this->assets_css[] = "admin.css";
        $data['partnerId']= $this->session->userdata('partner_id');
        $this->render_page_admin('admin/create_quest', $data);
    }
    
    public function packet(){
        $this->current_section = 'packet';
        $this->assets_css[] = 'admin.css';
        $this->assets_js[] = 'admin/packet.js';
        $this->render_page_admin('admin/packet');
    }
    
    public function under_construction(){
        $this->current_section = 'construct';
        $this->assets_css[] = "admin.css";
        $this->render_page_admin('home/under_construction');
    }
    
    public function help(){
        $this->current_section = 'help';
        $this->assets_css[] = "admin.css";
        $this->render_page_admin('home/help');
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
    
    public function test(){
        $this->load->view('login/login.inc.php');
    }
    
    /**
     * Test API
     */
    public  function testapi_s(){
        //$title= $this->input->post("title");
        $data = array(
            'code' => 1,
            'message' => "Quest Success",
            'info' => $_REQUEST,
        );
        echo json_encode($data);
    }
    
    public  function testapi_f(){
        $data = array(
            'code' => 0,
            'message' => "Quest Unsuccessful",
            'info' => "Ehh!!!",
        );
        echo json_encode($data);
    }
    
    public function getCategory(){
        echo '{
  "code": 1,
  "message": "Success",
  "info": {
    "category": [
      {
        "Id": 1,
        "CategoryName": "Children"
      },
      {
        "Id": 1,
        "CategoryName": "Children2"
      },
      {
        "Id": 1,
        "CategoryName": "Children3"
      },
      {
        "Id": 1,
        "CategoryName": "Children4"
      },
      {
        "Id": 1,
        "CategoryName": "Children5"
      }
    ]
  }
}';
    }
    
    public function getQuest(){
        echo '{
  "code": 1,
  "message": "Success",
  "info": {
    "quest": {
      "Id": 1,
      "QuestName": "abcxyz",
      "Title": "http://abcxyz",
      "PartnerName": "Actions Name",
      "UnlockPoint": 200,
      "CreatedDate": "2014/03/02",
      "PacketName": "HCM",
      "PacketId": 2
    },
    "condition": [
      {
        "Id": 1,
        "Type": 1,
        "ObjectId": 1,
        "ObjectName": "Donation 4$",
        "Value": 500
      },
      {
        "Id": 1,
        "Type": 1,
        "ObjectId": 1,
        "ObjectName": "Donation 4$",
        "Value": 500
      },
      {
        "Id": 1,
        "Type": 2,
        "ObjectId": 1,
        "ObjectName": "Donation 4$",
        "Value": 500
      },
      {
        "Id": 1,
        "Type": 2,
        "ObjectId": 1,
        "ObjectName": "Donation 4$",
        "Value": 500
      },
      {
        "Id": 1,
        "Type": 2,
        "ObjectId": 1,
        "ObjectName": "Donation 4$",
        "Value": 500
      }
    ]
  }
}';
    }
    
    public function getDonation(){
        echo '{
  "code": 1,
  "message": "Success",
  "info": {
    "donation": {
      "Id": 1,
      "PartnerId": 2,
      "Description": "abcxyz",
      "Title": "Donate, please",
      "PartnerName": "Partner Name",
      "RequiredPoint": 200,
      "CreatedDate": "2014/03/02",
      "IsApproved": 0
    }
  }
}';
    }
    
    public function getActivity(){
        echo '{
  "code": 1,
  "message": "Success",
  "info": {
    "activity": {
      "Id": 1,
      "PartnerId": 2,
      "ActionId": 1,
      "ActionContent": "Shere me",
      "Description": "Share to get more",
      "Title": "Share",
      "PartnerName": " Name",
      "BonusPoint": 300,
      "CreatedDate": "2014/03/02",
      "IsApproved": 0
    }
  }
}';
    }
    
    public function testactivity(){
        $data = '{
  "code": 1,
  "message": "Success",
  "info": {
    "activity": [
      {
        "Id": 1,
        "PartnerId": 2,
        "ActionContent": "abcxyz",
        "Description": "abcxyz",
        "Title": "Go to yeah",
        "Name": "Actions Name",
        "Point": 100,
        "CreatedDate": "2014/03/02"
      },
      {
        "Id": 2,
        "PartnerId": 2,
        "ActionContent": "abcxyz",
        "Description": "abcxyz",
        "Title": "Go to yeah://abcxyz",
        "Name": "Acts Name",
        "Point": 100,
        "CreatedDate": "2014/03/02"
      },
      {
        "Id": 3,
        "PartnerId": 2,
        "ActionContent": "abcxyz",
        "Description": "abcxyz",
        "Title": "Go to yeah://abcxyz",
        "Name": "As Name",
        "Point": 100,
        "CreatedDate": "2014/03/02"
      },
      {
        "Id": 1,
        "PartnerId": 2,
        "ActionContent": "abcxyz",
        "Description": "abcxyz",
        "Title": "Go to yeah://abcxyz",
        "Name": "Actios Name",
        "Point": 100,
        "CreatedDate": "2014/03/02"
      }
    ]
  }
}';
       echo json_encode(json_decode($data));
    }
    
    public function testapi(){
        $data = '{
  "code": 1,
  "message": "Success",
  "info": {
    "quiz": [
      {
        "Id": 1,
        "CategoryId": 1,
        "CreatedDate": 1002,
        "CorrectChoiceId": 1,
        "IsApproved": 1,
        "CategoryName": "Teaching",
        "Name": "KTO",
        "CreateDate": "2014/04/03"
      },
      {
        "Id": 2,
        "CategoryId": 1,
        "CreatedDate": 1002,
        "CorrectChoiceId": 1,
        "IsApproved": 0,
        "CategoryName": "Teaching",
        "Name": "Partners Name",
        "CreateDate": "2014/04/03"
      },
      {
        "Id": 3,
        "CategoryId": 0,
        "CreatedDate": 1002,
        "CorrectChoiceId": 1,
        "IsApproved": 1,
        "CategoryName": "Teaching",
        "Name": "Papa",
        "CreateDate": "2014/04/03"
      },
      {
        "Id": 4,
        "CategoryId": 1,
        "CreatedDate": 1002,
        "CorrectChoiceId": 1,
        "IsApproved": 1,
        "CategoryName": "Teaching",
        "Name": "Partners Name",
        "CreateDate": "2014/04/03"
      },
      {
        "Id": 5,
        "CategoryId": 0,
        "CreatedDate": 1002,
        "CorrectChoiceId": 1,
        "IsApproved": 1,
        "CategoryName": "Teaching",
        "Name": "Partners Name",
        "CreateDate": "2014/04/03"
      },
      {
        "Id": 6,
        "CategoryId": 1,
        "CreatedDate": 1002,
        "CorrectChoiceId": 1,
        "IsApproved": 1,
        "CategoryName": "Teaching",
        "Name": "Partners Name",
        "CreateDate": "2014/04/03"
      },
      {
        "Id": 1,
        "CategoryId": 1,
        "CreatedDate": 1002,
        "CorrectChoiceId": 1,
        "IsApproved": 1,
        "CategoryName": "Teaching",
        "Name": "Partners Name",
        "CreateDate": "2014/04/03"
      },
      {
        "Id": 1,
        "CategoryId": 1,
        "CreatedDate": 1002,
        "CorrectChoiceId": 1,
        "IsApproved": 1,
        "CategoryName": "Teaching",
        "Name": "Partners Name",
        "CreateDate": "2014/04/03"
      },
      {
        "Id": 1,
        "CategoryId": 1,
        "CreatedDate": 1002,
        "CorrectChoiceId": 1,
        "IsApproved": 0,
        "CategoryName": "Teaching",
        "Name": "Partners Name",
        "CreateDate": "2014/04/03"
      },
      {
        "Id": 1,
        "CategoryId": 1,
        "CreatedDate": 1002,
        "CorrectChoiceId": 1,
        "IsApproved": 1,
        "CategoryName": "Teaching",
        "Name": "Partners Name",
        "CreateDate": "2014/04/03"
      },
      {
        "Id": 1,
        "CategoryId": 1,
        "CreatedDate": 1002,
        "CorrectChoiceId": 1,
        "IsApproved": 0,
        "CategoryName": "Teaching",
        "Name": "Partners Name",
        "CreateDate": "2014/04/03"
      },
      {
        "Id": 1,
        "CategoryId": 1,
        "CreatedDate": 1002,
        "CorrectChoiceId": 1,
        "IsApproved": 1,
        "CategoryName": "Teaching",
        "Name": "Partners Name",
        "CreateDate": "2014/04/03"
      },
      {
        "Id": 1,
        "CategoryId": 1,
        "CreatedDate": 1002,
        "CorrectChoiceId": 1,
        "IsApproved": 0,
        "CategoryName": "Teaching",
        "Name": "Partners Name",
        "CreateDate": "2014/04/03"
      },
      {
        "Id": 1,
        "CategoryId": 1,
        "CreatedDate": 1002,
        "CorrectChoiceId": 1,
        "IsApproved": 1,
        "CategoryName": "Teaching",
        "Name": "Partners Name",
        "CreateDate": "2014/04/03"
      }
    ]
  }
}';
        echo json_encode(json_decode($data));
    }
    
    public function testDonation(){
        $data='{
  "code": 1,
  "message": "Success",
  "info": {
    "donation": [
      {
        "Id": 1,
        "PartnerId": 2,
        "Description": "abcxyz",
        "Title": "http://abcxyz",
        "Name": "Action Name",
        "RequiredPoint": 100,
        "CreatedDate": "2014/03/02",
        "IsApproved": 0
      },
      {
        "Id": 1,
        "PartnerId": 2,
        "Description": "abcxyz",
        "Title": "http://abcxyz",
        "Name": "Actio Name",
        "RequiredPoint": 100,
        "CreatedDate": "2014/03/02",
        "IsApproved": 1
      },
      {
        "Id": 1,
        "PartnerId": 2,
        "Description": "abcxyz",
        "Title": "http://abcxyz",
        "Name": "Actis Name",
        "RequiredPoint": 100,
        "CreatedDate": "2014/03/02",
        "IsApproved": 0
      },
      {
        "Id": 1,
        "PartnerId": 2,
        "Description": "abcxyz",
        "Title": "http://abcxyz",
        "Name": "Actions Name",
        "RequiredPoint": 100,
        "CreatedDate": "2014/03/02",
        "IsApproved": 1
      },
      {
        "Id": 1,
        "PartnerId": 2,
        "Description": "abcxyz",
        "Title": "http://abcxyz",
        "Name": "Actis Name",
        "RequiredPoint": 100,
        "CreatedDate": "2014/03/02",
        "IsApproved": 1
      },
      {
        "Id": 1,
        "PartnerId": 2,
        "Description": "abcxyz",
        "Title": "http://abcxyz",
        "Name": "As Name",
        "RequiredPoint": 100,
        "CreatedDate": "2014/03/02",
        "IsApproved": 1
      },
      {
        "Id": 1,
        "PartnerId": 2,
        "Description": "abcxyz",
        "Title": "http://abcxyz",
        "Name": "Actis Name",
        "RequiredPoint": 100,
        "CreatedDate": "2014/03/02",
        "IsApproved": 1
      }
    ]
  }
}';
        echo json_encode(json_decode($data));
    }
    
    public function testQuest(){
        $data = '{
  "code": 1,
  "message": "Success",
  "info": {
    "quest": [
      {
        "Id": 1,
        "QuestName": "Rescure",
        "PacketName": "HCM",
        "Point": 500,
        "CreatedDate": "2014/03/04"
      },
      {
        "Id": 1,
        "QuestName": "Rescure",
        "PacketName": "HCM",
        "Point": 500,
        "CreatedDate": "2014/03/04"
      },
      {
        "Id": 1,
        "QuestName": "Rescure",
        "PacketName": "HCM",
        "Point": 500,
        "CreatedDate": "2014/03/04"
      },
      {
        "Id": 1,
        "QuestName": "Rescure",
        "PacketName": "HCM",
        "Point": 500,
        "CreatedDate": "2014/03/04"
      },
      {
        "Id": 1,
        "QuestName": "Rescure",
        "PacketName": "HCM",
        "Point": 500,
        "CreatedDate": "2014/03/04"
      },
      {
        "Id": 1,
        "QuestName": "Rescure",
        "PacketName": "HCM",
        "Point": 500,
        "CreatedDate": "2014/03/04"
      },
      {
        "Id": 1,
        "QuestName": "Rescure",
        "PacketName": "HCM",
        "Point": 500,
        "CreatedDate": "2014/03/04"
      },
      {
        "Id": 1,
        "QuestName": "Rescure",
        "PacketName": "HCM",
        "Point": 500,
        "CreatedDate": "2014/03/04"
      },
      {
        "Id": 1,
        "QuestName": "Rescure",
        "PacketName": "HCM",
        "Point": 500,
        "CreatedDate": "2014/03/04"
      },
      {
        "Id": 1,
        "QuestName": "Rescure",
        "PacketName": "HCM",
        "Point": 500,
        "CreatedDate": "2014/03/04"
      },
      {
        "Id": 1,
        "QuestName": "Rescure",
        "PacketName": "HCM",
        "Point": 500,
        "CreatedDate": "2014/03/04"
      }
    ]
  }
}';
        echo $data;
    }
    
    public function testPackets(){
        $data = '{
  "code": 1,
  "message": "Success",
  "info": {
    "packet": [
      {
        "Id": 1,
        "Title": "Ho Chi Minh"
      },
      {
        "Id": 1,
        "Title": "Ho Chi Minh"
      },
      {
        "Id": 1,
        "Title": "Ho Chi Minh"
      }
    ]
  }
}';
        echo $data;
    }
    
    public function testCate(){
        echo '{
  "code": 1,
  "message": "Success",
  "info": {
    "category": [
      {
        "Id": 1,
        "CategoryName": "Children"
      },
      {
        "Id": 1,
        "CategoryName": "Children2"
      },
      {
        "Id": 1,
        "CategoryName": "Children3"
      },
      {
        "Id": 1,
        "CategoryName": "Children4"
      },
      {
        "Id": 1,
        "CategoryName": "Children5"
      }
    ]
  }
}';
    }
}