<!DOCTYPE html>
<html lang='en'>
    <head>
        <meta name="viewport" content='width=device-width, initial-scale=1'>
        <title>Login</title>

        <link rel="stylesheet" type="text/css" href="<?php echo base_url(); ?>assets/css/bootstrap.min.css" media="screen" />
        <link rel="stylesheet" type="text/css" href="<?php echo base_url(); ?>assets/css/login.css" media="screen" />
        <link rel="shortcut icon" href="<?php echo base_url(); ?>assets/img/favicon.ico" type="image/x-ico">
        
        <script type="text/javascript" src="<?php echo base_url(); ?>assets/js/jquery-1.9.1.min.js"></script>
    </head>
    <body>
        <div class="container">
        <div class='content-center'>
            
            
        <form class="form-horizontal" action ='' method='POST'>
            <fieldset>
                <img src='<?php echo base_url(); ?>assets/img/sign_up_logo.png' class='img-responsive img-center' alt='Hero For Zero'>
                <!-- Text input-->
                <div class="form-group">
                    <label class="col-md-4 control-label" for="username"></label>  
                    <div class="col-md-4">
                        <input id="username" name="username" type="text" value="<?php echo set_value('username'); ?>" placeholder="Username" class="form-control input-md" required="">
                    </div>
                </div>

                <!-- Password input-->
                <div class="form-group">
                    <label class="col-md-4 control-label" for="password"></label>
                    <div class="col-md-4">
                        <input id="password" name="password" type="password" placeholder="Password" class="form-control input-md" required="">

                    </div>
                </div>

                <!-- Button -->
                <div class="form-group">
                    <label class="col-md-4 control-label" for="login"></label>
                    <div class="col-md-4">
                        <button id="login" name="login" class="btn btn-block btn-primary">Sign me in</button>
                        <div id="ack"></div>
                    </div>
                    
                </div>

                <!-- Multiple Checkboxes (inline) -->
                <div class="form-group">
                    <label class="col-md-4 control-label" for="remember"></label>
                    <div class="col-md-4">
                        <div class="col-md-7">
                                <input type="checkbox" name="remember" id="remember" value="1">
                                Keep me sign in
                        </div>
                        <div class="col-md-5">
                            <a href='<?php echo base_url(); ?>signup'> Sign me up </a>
                        </div>
                    </div>
                    </div>

            </fieldset>
        </form>
        </div>
        </div>
    </body>
</html>