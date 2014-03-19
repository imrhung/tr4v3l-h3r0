<?php

defined('BASEPATH') OR exit('No direct script access allowed');

class Process extends App_Controller {

    public function __construct() {
        parent::__construct();
		
    }

    public function upload_image() {
		$this->current_section = 'upload_image';
		//$this->assets_js[] = '';
		$this->assets_js[] = 'upload_images/ajax_upload.js';
		$this->assets_css[] = 'admin.css';
		$this->render_page_admin('test_upload');
	}
	
	public function uploadfunction() {
				
		error_reporting(E_ALL);
		include('Upload.php');
		
		// retrieve eventual CLI parameters
		$cli = (isset($argc) && $argc > 1);
		if ($cli) {
			if (isset($argv[1])) $_GET['file'] = $argv[1];
			if (isset($argv[2])) $_GET['dir'] = $argv[2];
			if (isset($argv[3])) $_GET['pics'] = $argv[3];
		}

		// set variables
		$dir_dest = (isset($_GET['dir']) ? $_GET['dir'] : 'test');
		$dir_pics = (isset($_GET['pics']) ? $_GET['pics'] : $dir_dest);

		// we have three forms on the test page, so we redirect accordingly
		if ((isset($_POST['action']) ? $_POST['action'] : (isset($_GET['action']) ? $_GET['action'] : '')) == 'simple') {
			$handle = new Upload($_FILES['my_field']);

			if ($handle->uploaded) {
				$handle->image_resize = true;
				$handle->image_ratio_y = true;
				$handle->image_x = 50;
				
				$handle->Process($dir_dest);

				// we check if everything went OK
				if ($handle->processed) {
					$url = $dir_pics . '/' . $handle->file_dst_name;
					
					//$this->load->library('s3_config');
					$bucket="mytempbucket";
					if (!class_exists('S3'))
						require_once('S3.php');

					//AWS access info
					if (!defined('awsAccessKey')) define('awsAccessKey', 'AKIAJIWOJ6L32GWAUUUQ');
					if (!defined('awsSecretKey')) define('awsSecretKey', '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');

					$s3 = new S3(awsAccessKey, awsSecretKey);
					$s3->putBucket($bucket, S3::ACL_PUBLIC_READ);
					
					//Rename image name. 
					$actual_image_name = time().".".$ext;
					if($s3->putObjectFile($url, $bucket , $actual_image_name, S3::ACL_PUBLIC_READ)) {
						$s3file='http://'.$bucket.'.s3.amazonaws.com/'.$actual_image_name;
						echo "<p style='color: blue'>Image upload successfull.</p><img id='imgPreview' src='" . $s3file . "'/>";
					} else
						echo '<p style="color: red">S3 Upload Fail.</p>';
				} else {
					// one error occured
					echo '  Error: ' . $handle->error . '';
				}

				// we delete the temporary files
				$handle-> Clean();
				
				
			} else {
				// if we're here, the upload file failed for some reasons
				// i.e. the server didn't receive the file
				echo '  Error: ' . $handle->error . '';
			}
		}
	}
}