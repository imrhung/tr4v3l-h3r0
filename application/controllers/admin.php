<?php

defined('BASEPATH') OR exit('No direct script access allowed');

class Admin extends App_Controller {

    public function __construct() {
        parent::__construct();
        $this->load->model('user_model');

        // Check if login
        if ($this->session->userdata('islogin')) {
            if ($this->session->userdata('role') == 'admin') {
                //redirect('admin');
            } else if ($this->session->userdata('role') == 'organization') {
                //redirect('organization');
                //$this->load->view('home/unauthorized');
                redirect('home/unauthorized');
            }
        } else {
            redirect('home/unauthorized');
        }
    }

    public function index() {
        $this->page_title = 'Home';
        $this->current_section = 'home';
        $this->assets_css[] = 'datatables/jquery.dataTables.css';
        //$this->assets_css[] = 'datatables/data-bootstrap.css';
        $this->assets_css[] = 'datatables/dataTables.bootstrap.css';
        $this->assets_js[] = 'datatables/jquery.dataTables.js';
        $this->assets_js[] = 'datatables/pagebootstrap.js';
        $this->assets_js[] = 'admin/index.js';
        $this->assets_js[] = 'bootbox/bootbox.min.js';
        $this->render_page_admin('admin/index');
    }

    public function edit_quiz($id = NULL) {
        if ($id == NULL) {
            redirect("admin/index");
        } else {
            $this->page_title = 'Edit Quiz';
            $this->current_section = "edit_quiz";
            $this->assets_js[] = 'admin/edit_quiz.js';
            $this->assets_js[] = 'bootbox/bootbox.min.js';
            $data = array(
                'quizId' => $id,
            );
            $this->render_page_admin('admin/edit_quiz', $data);
        }
    }

    public function edit_activity($id = NULL) {
        if ($id == NULL) {
            redirect("admin/index");
        } else {
            $this->page_title = 'Edit Activity';
            $this->current_section = "edit_quiz";
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

    public function edit_donation($id = NULL) {
        if ($id == NULL) {
            redirect("admin/index");
        } else {
            $this->page_title = 'Edit Donation';
            $this->current_section = "edit_donation";
            $this->assets_js[] = 'admin/edit_donation.js';
            $this->assets_js[] = 'bootbox/bootbox.min.js';

            $data = array(
                'donationId' => $id
            );
            $this->render_page_admin('admin/edit_donation', $data);
        }
    }

    public function edit_quest($id = NULL) {
        if ($id == NULL) {
            redirect("admin/index");
        } else {
            $this->page_title = 'Edit Quest';
            $this->current_section = "edit_quest";
            $this->assets_css[] = 'image-picker/image-picker.css';
            $this->assets_js[] = 'image-picker/image-picker.js';
            $this->assets_js[] = 'admin/edit_quest.js';
            $this->assets_js[] = 'bootbox/bootbox.min.js';

            $data = array(
                'questId' => $id,
                'edit_quest' => 1,
                'partnerId' => $this->session->userdata('partner_id')
            );
            $this->render_page_admin('admin/create_quest', $data);
        }
    }

    public function create_quest() {
        $this->page_title = 'Create Quest';
        $this->current_section = 'create_quest';
        $this->assets_css[] = 'image-picker/image-picker.css';
        $this->assets_js[] = 'image-picker/image-picker.js';
        $this->assets_js[] = 'admin/create_quest.js';
        $data = array(
                'questId' => 0,
                'edit_quest' => 0,
                'partnerId' => $this->session->userdata('partner_id')
            );
        $this->render_page_admin('admin/create_quest', $data);
    }
    
    public function create_animation(){
        $this->page_title = 'Create Animation';
        $this->current_section = 'packet';
        $this->assets_css[] = 'bootstrap-colorpicker/css/bootstrap-colorpicker.css';
        $this->assets_js[] = 'bootstrap-colorpicker/bootstrap-colorpicker.js';
        $this->assets_js[] = 'admin/create_animation.js';
        $data = array(
                'questId' => 0,
                'edit_quest' => 0,
                'partnerId' => $this->session->userdata('partner_id')
            );
        $this->render_page_admin('admin/create_animation', $data);
    }

    public function packet() {
        $this->page_title = 'Packet and Category';
        $this->current_section = 'packet';
        $this->assets_js[] = 'admin/packet.js';
        $this->render_page_admin('admin/packet');
    }
    
    public function edit_packet($id = NULL){
        if ($id == NULL) {
            redirect("admin/index");
        } else {
            $this->page_title = "Edit Packet";
            $this->current_section = "packet";
            $this->assets_js[] = 'admin/edit_packet.js';
            $this->assets_js[] = 'bootbox/bootbox.min.js';

            $data = array(
                'packetId' => $id
            );
            $this->render_page_admin('admin/edit_packet', $data);
        }
        
    }

    public function partners() {
        $this->page_title = 'Partners';
        $this->current_section = 'partners';
        $this->assets_css[] = 'datatables/jquery.dataTables.css';
        $this->assets_css[] = 'datatables/dataTables.bootstrap.css';
        $this->assets_js[] = 'datatables/jquery.dataTables.js';
        $this->assets_js[] = 'datatables/pagebootstrap.js';
        $this->assets_js[] = 'bootbox/bootbox.min.js';
        $this->assets_js[] = 'admin/partners.js';
        $this->render_page_admin('admin/partners');
    }
    
    public function partner($id = NULL){
        if ($id == NULL) {
            redirect("admin/index");
        } else {
            $this->page_title = 'Partner';
            $this->current_section = "partners";
            $this->assets_js[] = 'admin/partner.js';
            $this->assets_js[] = 'bootbox/bootbox.min.js';

            $data = array(
                'partnerId' => $id
            );
            $this->render_page_admin('admin/partner', $data);
        }
    }
    
    public function players(){
        $this->page_title = 'Players';
        $this->current_section = 'players';
        $this->assets_css[] = 'datatables/jquery.dataTables.css';
        $this->assets_css[] = 'datatables/dataTables.bootstrap.css';
        $this->assets_js[] = 'datatables/jquery.dataTables.js';
        $this->assets_js[] = 'datatables/pagebootstrap.js';
        $this->assets_js[] = 'bootbox/bootbox.min.js';
        $this->assets_js[] = 'admin/players.js';
        $this->render_page_admin('admin/players');
    }
    
    //change password
    function change_password() {
        $this->form_validation->set_rules('old', 'Old password', 'required');
        $this->form_validation->set_rules('new', 'New password', 'required|matches[new_confirm]|min_length[6]|max_length[32]');
        $this->form_validation->set_rules('new_confirm', 'Confirm password', 'required');

        if ( ! $this->session->userdata('islogin')) {
            redirect('login', 'refresh');
        }

        // Get the partner ID
        $partnerId = $this->session->userdata('partner_id');

        if ($this->form_validation->run() == false) {
            //display the form
            //set the flash data error message if there is one
            $this->data['message'] = (validation_errors()) ? validation_errors() : $this->session->flashdata('message');

            $this->data['min_password_length'] = $this->config->item('min_password_length', 'ion_auth');
            $this->data['old_password'] = array(
                'name' => 'old',
                'id' => 'old',
                'type' => 'password',
                'required'=>'',
                'class' => 'form-control'
            );
            $this->data['new_password'] = array(
                'name' => 'new',
                'id' => 'new',
                'type' => 'password',
                'required'=>'',
                'pattern' => '.{6,}',
                'title' => "6 characters minimum",
                'class' => 'form-control'
            );
            $this->data['new_password_confirm'] = array(
                'name' => 'new_confirm',
                'id' => 'new_confirm',
                'type' => 'password',
                'required'=>'',
                'pattern' => '.{6,}',
                'title' => "6 characters minimum",
                'class' => 'form-control'
            );
            $this->data['user_id'] = array(
                'name' => 'user_id',
                'id' => 'user_id',
                'type' => 'hidden',
                'value' => $partnerId,
            );

            //render page base on role
            $this->render_page_admin('user/change_password', $this->data);
        } else {
            $change = $this->user_model->changePassword($partnerId, $this->input->post('old'), $this->input->post('new'));

            if ($change) {
                //if the password was successfully changed
                $this->session->set_flashdata('message', 'Change successful!');
                redirect('admin/change_password', 'refresh');
            } else {
                $this->session->set_flashdata('message', 'Old password not correct!');
                redirect('admin/change_password', 'refresh');
            }
        }
    }

    public function under_construction() {
        $this->page_title = 'Under Construction';
        $this->current_section = 'construct';
        $this->render_page_admin('home/under_construction');
    }

    public function help() {
        $this->page_title = 'Help';
        $this->current_section = 'help';
        $this->render_page_admin('home/help');
    }

    /**
     * Fake API to test. 
     */
    public function testapi_s() {
        //$title= $this->input->post("title");
        $data = array(
            'code' => 1,
            'message' => "Quest Success",
            'info' => $_REQUEST,
        );
        echo json_encode($data);
    }

    public function testapi_f() {
        $data = array(
            'code' => 0,
            'message' => "Quest Unsuccessful",
            'info' => "Ehh!!!",
        );
        echo json_encode($data);
    }

    public function getPartner(){
        echo '{
  "code": 1,
  "message": "Success",
  "info": {
    "partner": {
      "Id": 1,
      "PartnerName": "Earth Hour",
      "OrganizationTypeId": 2,
      "Address": "2323 tesdf",
      "PhoneNumber": 1234,
      "WebsiteURL": "http://sdf",
      "Latitude": 12.234,
      "Longitude": 14.1203,
      "Description": "We save the world.",
      "UserName": "imrhung",
      "Email": "imrhung@yahoo.com",
      "IsApproved": 1
    }
  }
}';
    }
    
    public function getPartners(){
        echo '{
  "code": 1,
  "message": "Success",
  "info": {
    "partners": [
      {
        "Id": 1,
        "PartnerName": "Earth Hour",
        "OrganizationTypeId": 2,
        "Address": "2323 tesdf",
        "PhoneNumber": 1234,
        "WebsiteURL": "http://sdf",
        "Latitude": 12.234,
        "Longitude": 14.1203,
        "Description": "We save the world.",
        "IsApproved": 1
      },
      {
        "Id": 1,
        "PartnerName": "Earth Hour",
        "OrganizationTypeId": 2,
        "Address": "2323 tesdf",
        "PhoneNumber": 1234,
        "WebsiteURL": "http://sdf",
        "Latitude": 12.234,
        "Longitude": 14.1203,
        "Description": "We save the world.",
        "IsApproved": 0
      }
    ]
  }
}';
    }
    
    public function getCategory() {
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

    public function getQuest() {
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

    public function getDonation() {
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

    public function getActivity() {
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

    public function testactivity() {
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

    public function testapi() {
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

    public function testDonation() {
        $data = '{
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

    public function testQuest() {
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

    public function testPackets() {
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

    public function testCate() {
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
