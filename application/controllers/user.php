<?php

defined('BASEPATH') OR exit('No direct script access allowed');

class User extends App_Controller {

    public function __construct() {
        parent::__construct();
        $this->load->model('user_model');
    }

    public function index() {
        redirect('login');
    }

    public function login() {
        
        // Check if login
        if ($this->session->userdata('islogin')) {
            if ($this->session->userdata('role') == 'admin') {
                redirect('admin');
            } else if ($this->session->userdata('role') == 'organization') {
                redirect('organization');
            }
        }
        
        $this->load->helper(array('form', 'url'));
        $this->load->library('form_validation');
        $this->form_validation->set_rules('username', 'Username', 'required');
		$this->form_validation->set_rules('password', 'Password', 'required');
        
        if ($this->form_validation->run() == FALSE) {
            $this->load->view('user/login');
        } else {
            // Check username and password.
            $username = $this->input->post('username');
            $password = $this->input->post('password');
            $valid = $this->user_model->login($username, $password);
            
            if ($valid){
                // Check role
                $userId = $this->user_model->getUserId($username);
                $roleId = $this->user_model->getRoleId($userId);
                $partnerId = $this->user_model->getPartnerId($userId);
                if ($roleId == 4) { // Organization
                    
                    // Store to session
                    $sess_array = array(
                        'islogin' => TRUE,
                        'partner_id' => $partnerId,
                        'role' => "organization"
                    );
                    $this->session->set_userdata($sess_array);
                    // Load view
                    redirect("organization/index");
                    
                } else if ($roleId == 3){ // Unicef
                    // Store to session
                    $sess_array = array(
                        'islogin' => TRUE,
                        'role' => "admin",
                        'partner_id' => $partnerId,
                    );
                    $this->session->set_userdata($sess_array);
                    // Load view
                    redirect("admin/index");
                
                }
            } else {
                // Incorrect login
                $this->load->view('user/login');
            }
        }
    }

    public function process() {
        //This method will have the credentials validation
        $this->load->library('form_validation');

        $this->form_validation->set_rules('username', 'Username', 'trim|required|xss_clean');
        $this->form_validation->set_rules('password', 'Password', 'trim|required|xss_clean|callback_check_database');

        if ($this->form_validation->run() == FALSE) {
            //Field validation failed.  User redirected to login page
            $this->load->view('user/login');
        } else {
            //Go to private area
            redirect('home', 'refresh');
        }
    }

    function check_database($password) {
        //Field validation succeeded.  Validate against database
        $username = $this->input->post('username');

        //query the database
        $result = $this->user->login($username, $password);

        if ($result) {
            $sess_array = array();
            foreach ($result as $row) {
                $sess_array = array(
                    'id' => $row->id,
                    'username' => $row->username
                );
                $this->session->set_userdata('logged_in', $sess_array);
            }
            return TRUE;
        } else {
            $this->form_validation->set_message('check_database', 'Invalid username or password');
            return false;
        }
    }

    public function logout() {
        // log the user out
        $this->session->sess_destroy();

        // redirect them back to the login page
        redirect('/user/login');
    }

    public function signup() {
        $this->load->helper(array('form', 'url'));

        $this->load->library('form_validation');
        
        $config = array(
            array(
                'field'=> 'username',
                'label'=> 'Username',
                'rules'=> 'trim|required|min_length[6]|is_unique[UserPartner.UserName]|xss_clean'
            ),
            array(
                'field'=> 'password',
                'label'=> 'Password',
                'rules'=> 'trim|required|min_length[6]|max_length[32]'
            ),
            array(
                'field'=> 'passconf',
                'label'=> 'Confirm Password',
                'rules'=> 'trim|required|matches[password]'
            ),
            array(
                'field'=> 'name',
                'label'=> 'Organization\'s Name',
                'rules'=> 'trim|required'
            ),
            array(
                'field'=> 'admin_name',
                'label'=> 'Administrator Name',
                'rules'=> 'trim|required'
            ),
            array(
                'field'=> 'email',
                'label'=> 'Contact Email',
                'rules'=> 'trim|required'
            ),
            array(
                'field'=> 'address',
                'label'=> 'Organization\'s Address',
                'rules'=> 'trim|required'
            ),
            array(
                'field'=> 'phone',
                'label'=> 'Phone Number',
                'rules'=> 'trim|required'
            ),
            array(
                'field'=> 'website',
                'label'=> 'Website',
                'rules'=> 'trim'
            ),
            array(
                'field'=> 'type',
                'label'=> 'Organization type',
                'rules'=> ''
            ),
            array(
                'field'=> 'description',
                'label'=> 'Description',
                'rules'=> 'trim|required'
            ),
        );
        
        $this->form_validation->set_rules($config);
        
        if ($this->form_validation->run() == FALSE) {
            $this->load->view('user/signup');
        } else {
            // Add user
            $partnerId = $this->user_model->register(
                    $this->input->post('username'),
                    $this->input->post('password'),
                    $this->input->post('name'),
                    $this->input->post('admin_name'),
                    $this->input->post('email'),
                    $this->input->post('address'),
                    $this->input->post('phone'),
                    $this->input->post('website'),
                    $this->input->post('type'),
                    $this->input->post('description')
                    );
            
            // Store to session
            $sess_array = array(
                'islogin' => TRUE,
                'partner_id' => $partnerId,
                'role' => "organization"
            );
            $this->session->set_userdata($sess_array);
            
            // Redirect to proper page.
            redirect('organization/index');
        }
    }

}