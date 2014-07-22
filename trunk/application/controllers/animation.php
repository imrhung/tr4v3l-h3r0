<?php

/* 
 * Code written by Nguyen Van Hung at @imrhung
 * Feel free to re-use or share it.
 * Happy code!!!
 */

defined('BASEPATH') OR exit('No direct script access allowed');

class Animation extends App_Controller{
    
    function __construct() {
        parent::__construct();
    }
    
    function index(){
        echo "it's index";
    }
    
    function see(){
       $this->load->view('user/login');
    }
    
}

