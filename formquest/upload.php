<?php

error_reporting(E_ALL);

// we first include the upload class, as we will need it here to deal with the uploaded file
include('class.upload.php');

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
			include('s3_controllers/imagecheck.php');
			include('s3_controllers/s3_config.php');
			//Rename image name. 
			$actual_image_name = time().".".$ext;
			if($s3->putObjectFile($url, $bucket , $actual_image_name, S3::ACL_PUBLIC_READ)) {
				$s3file='http://'.$bucket.'.s3.amazonaws.com/'.$actual_image_name;
				echo '<div class="alert alert-dismissable alert-success"> 
						<button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
						Image upload successfull.
					</div><img id="imgPreview" src="' . $s3file . '"/>';
				
			} else
				echo '<div class="alert alert-dismissable alert-danger"> 
						<button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
						S3 Upload fail.
					</div>';
        } else {
            // one error occured
			echo '<div class="alert alert-dismissable alert-danger"> 
						<button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
						Error: '. $handle->error.'.
					</div>';
        }

        // we delete the temporary files
        $handle-> Clean();
		
		
    } else {
        // if we're here, the upload file failed for some reasons
        // i.e. the server didn't receive the file
        echo '  Error: ' . $handle->error . '';
    }
}