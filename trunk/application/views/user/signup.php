<!DOCTYPE html>
<html lang='en'>
    <head>
        <meta name="viewport" content='width=device-width, initial-scale=1'>
        <title>Sign Up</title>

        <link rel="stylesheet" type="text/css" href="<?php echo base_url(); ?>assets/css/bootstrap.min.css" media="screen" />
        <link rel="stylesheet" type="text/css" href="<?php echo base_url(); ?>assets/css/login.css" media="screen" />
        
        <script type="text/javascript" src="<?php echo base_url(); ?>assets/js/jquery-1.9.1.min.js"></script>
    </head>
    <body>
        <div class='content-center'>

            <form class="form-horizontal" method='POST'>
                <fieldset>

                    <img src='<?php echo base_url(); ?>assets/img/sign_up_logo.png' class='img-responsive img-center' alt='Hero For Zero'>
                    <p class='col-md-12 img-center'>
                        Fill out the information below to join Hero for Zero program
                    </p>
                    <br><br><br><br>
                    <div class='col-md-12 img-center'>
                        <?php echo validation_errors(); ?>
                    </div>
                    <!-- Text input-->
                    <div class="form-group">
                        <label class="col-md-4 control-label" for="username">Username</label>  
                        <div class="col-md-4">
                            <input id="username" name="username" type="text" value="<?php echo set_value('username'); ?>" placeholder="Your username to login later" class="form-control input-md" required="">

                        </div>
                    </div>

                    <!-- Password input-->
                    <div class="form-group">
                        <label class="col-md-4 control-label" for="password">Password</label>
                        <div class="col-md-4">
                            <input id="password" name="password" type="password" value="<?php echo set_value('password'); ?>" placeholder="And password" class="form-control input-md" required="">

                        </div>
                    </div>

                    <!-- Password confirm input-->
                    <div class="form-group">
                        <label class="col-md-4 control-label" for="passconf">Confirm Password</label>
                        <div class="col-md-4">
                            <input id="passconf" name="passconf" type="password" value="<?php echo set_value('passconf'); ?>" placeholder="Rewrite your password" class="form-control input-md" required="">

                        </div>
                    </div>


                    <!-- Text input-->
                    <div class="form-group">
                        <label class="col-md-4 control-label" for="name">Organization's Name</label>  
                        <div class="col-md-4">
                            <input id="name" name="name" type="text" value="<?php echo set_value('name'); ?>" placeholder="" class="form-control input-md" required="">

                        </div>
                    </div>

                    <!-- Text input-->
                    <div class="form-group">
                        <label class="col-md-4 control-label" for="admin_name">Administrator Name</label>  
                        <div class="col-md-4">
                            <input id="admin_name" name="admin_name" type="text" value="<?php echo set_value('admin_name'); ?>" placeholder="" class="form-control input-md" required="">

                        </div>
                    </div>

                    <!-- Text input-->
                    <div class="form-group">
                        <label class="col-md-4 control-label" for="email">Contact Email</label>  
                        <div class="col-md-4">
                            <input id="email" name="email" type="email" value="<?php echo set_value('email'); ?>" placeholder="" class="form-control input-md" required="">

                        </div>
                    </div>

                    <!-- Text input-->
                    <div class="form-group">
                        <label class="col-md-4 control-label" for="address">Organization's Address</label>  
                        <div class="col-md-4">
                            <input id="address" name="address" type="text" value="<?php echo set_value('address'); ?>" placeholder="" class="form-control input-md" required="">

                        </div>
                    </div>

                    <!-- Text input-->
                    <div class="form-group">
                        <label class="col-md-4 control-label" for="phone">Phone Number</label>  
                        <div class="col-md-4">
                            <input id="phone" name="phone" type="tel" value="<?php echo set_value('phone'); ?>" placeholder="" class="form-control input-md" required="">

                        </div>
                    </div>

                    <!-- Text input-->
                    <div class="form-group">
                        <label class="col-md-4 control-label" for="website">Website (if applicable)</label>  
                        <div class="col-md-4">
                            <input id="website" name="website" type="url" value="<?php echo set_value('website'); ?>" placeholder="" class="form-control input-md">

                        </div>
                    </div>

                    <!-- Select Basic -->
                    <div class="form-group">
                        <label class="col-md-4 control-label" for="type">Organization Type</label>
                        <div class="col-md-4">
                            <select id="type" name="type" class="form-control">
                                <option value="1" <?php echo set_select('type', '1', TRUE); ?> >Goverment</option>
                                <option value="2" <?php echo set_select('type', '2'); ?> >Local NGO</option>
                                <option value="3" <?php echo set_select('type', '3'); ?> >International NGO</option>
                                <option value="4" <?php echo set_select('type', '4'); ?> >Charity</option>
                            </select>
                        </div>
                    </div>

                    <!-- Text input-->
                    <div class="form-group">
                        <label class="col-md-4 control-label" for="description">Description/ Mission</label>  
                        <div class="col-md-4">
                            <input id="description" name="description" type="text" value="<?php echo set_value('description'); ?>" placeholder="Limits to 50 words." class="form-control input-md" required="">

                        </div>
                    </div>

                    <!-- Button -->
                    <div class="form-group">
                        <label class="col-md-4 control-label" for="submit"></label>
                        <div class="col-md-4">
                            <button id="submit" name="submit" class="btn btn-block btn-primary">Submit Information</button>
                            <div id="ack"></div>
                        </div>
                    </div>

                </fieldset>
            </form>


        </div>
    </body>
</html>