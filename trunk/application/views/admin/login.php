<!DOCTYPE html>
<html lang='en'>
    <head>
        <meta name="viewport" content='width=device-width, initial-scale=1'>
        <title>Login</title>

        <link rel="stylesheet" type="text/css" href="<?php echo base_url(); ?>assets/css/bootstrap.min.css" media="screen" />
        <link rel="stylesheet" type="text/css" href="<?php echo base_url(); ?>assets/css/login.css" media="screen" />
        
        <script type="text/javascript" src="<?php echo base_url(); ?>assets/js/jquery-1.9.1.min.js"></script>
        <script type="text/javascript" src="<?php echo base_url(); ?>assets/js/admin/login.js"></script>
    </head>
    <body>
        <div class='content-center'>
            
            
        <form class="form-horizontal" action =''>
            <fieldset>
                <img src='<?php echo base_url(); ?>assets/img/sign_up_logo.png' class='img-responsive img-center' alt='Hero For Zero'>
                <!-- Text input-->
                <div class="form-group">
                    <label class="col-md-4 control-label" for="username"></label>  
                    <div class="col-md-4">
                        <input id="username" name="username" type="text" placeholder="Username" class="form-control input-md" required="">

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
                        <button type='button' id="login" name="login" class="btn btn-block btn-primary">Sign me in</button>
                        <div id="ack"></div>
                    </div>
                    
                </div>

                <!-- Multiple Checkboxes (inline) -->
                <div class="form-group">
                    <div class=''>
                    <label class="col-md-4 control-label" for="remember"></label>
                    <div class="col-md-3">
                        <label class="checkbox-inline checkbox" for="remember">
                            <input type="checkbox" name="remember" id="remember" value="1">
                            Keep me sign in
                        </label>
                    </div>
                    </div>
                    <div class=''>
                        <a href='<?php echo base_url(); ?>admin/signup'> Sign me up </a>
                    </div>
                </div>

            </fieldset>
        </form>
        </div>
    </body>
</html>