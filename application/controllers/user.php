<?php

defined('BASEPATH') OR exit('No direct script access allowed');

class User extends App_Controller {

    public function __construct() {
        parent::__construct();
        $this->load->model('user_model');
        $this->load->library('simple_mail');
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

            if ($valid) {
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
                } else if ($roleId == 3) { // Unicef
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
                'field' => 'username',
                'label' => 'Username',
                'rules' => 'trim|required|min_length[6]|is_unique[userpartner.UserName]|xss_clean'
            ),
            array(
                'field' => 'password',
                'label' => 'Password',
                'rules' => 'trim|required|min_length[6]|max_length[32]'
            ),
            array(
                'field' => 'passconf',
                'label' => 'Confirm Password',
                'rules' => 'trim|required|matches[password]'
            ),
            array(
                'field' => 'name',
                'label' => 'Organization\'s Name',
                'rules' => 'trim|required'
            ),
            array(
                'field' => 'admin_name',
                'label' => 'Administrator Name',
                'rules' => 'trim|required'
            ),
            array(
                'field' => 'email',
                'label' => 'Contact Email',
                'rules' => 'trim|required'
            ),
            array(
                'field' => 'address',
                'label' => 'Organization\'s Address',
                'rules' => 'trim|required'
            ),
            array(
                'field' => 'phone',
                'label' => 'Phone Number',
                'rules' => 'trim|required'
            ),
            array(
                'field' => 'website',
                'label' => 'Website',
                'rules' => 'trim'
            ),
            array(
                'field' => 'type',
                'label' => 'Organization type',
                'rules' => ''
            ),
            array(
                'field' => 'description',
                'label' => 'Description',
                'rules' => 'trim|required'
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
    
    /**
     * Verify user by Email address
     */

    /**
     * Below are functions to send mail.
     * Actually this function should be run asynchronized make user feel comfortable.
     * Untill now, this function still run with main process, so that the process may
     * a little bit slow.
     */

    /**
     * Send mail to user announce that they had registered successfully. Now they will until
     * admin approve them.
     * Return 'true' if send mail successful. Otherwise, return 'false'.
     */
    private function sendWaitMail($emailTo) {
        $subject = 'Welcome to Hero for Zero Program';
        $message = 'Thank you for your time registering "for Hero for Zero" program. We will need some time to process your '
                . 'information before appoving your application. We will send you an email when your approval process complete.'
                . ' Best regards, "Hero for Zero" team.';
        
        // Send mail:
        return $this->simple_mail->sendMail($emailTo, $subject, $message);
    }

    /**
     * Send mail to admin announce that there are a new user registered.
     */
    private function sendAnnouceAdminMail($emailTo) {
        $subject = 'A new NGO registered in Hero for Zero Program';
        $message = 'Hi admin,'
                . 'There are a new NGO registered. Please go to admin panel (on http://www.travelhero.be ) and approve or deny them.';
        
        // Send mail:
        return $this->simple_mail->sendMail($emailTo, $subject, $message);
    }

    /**
     * Send mail to user announce that they have been approved by the admin.
     */
    private function sendSuccessMail($emailTo) {
        $subject = 'You had been approved to Hero for Zero program';
        $message = 'Welcome to "Hero for Zero" program. You can visit page on http://www.travelhero.be';
        
        // Send mail:
        return $this->simple_mail->sendMail($emailTo, $subject, $message);
    }

    /**
     * Send mail to user announce that they have been denied by the admin.
     */
    public function sendDenyMail() {
        $subject = 'Hero for Zero program - Please sign up again.';
        $message = 'Some of your information may not correct so we cannot approve your account right now. '
                . 'Please consider to register again with more detail informaiton. '
                . 'Best regards,';
        
        // Send mail:
        return $this->simple_mail->sendMail($emailTo, $subject, $message);
    }
    /**
     * End of mail functions
     */
}
