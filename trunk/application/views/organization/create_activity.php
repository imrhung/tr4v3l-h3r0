<div id="wrapper">


    <div id="page-wrapper">

        <h1>Create Activity</h1>
        <p>To Create an Activity please fill out the information below.</p>

        <form class="form-horizontal">
            <fieldset>
                
                <!-- Form Name -->
                <legend></legend>

                <!-- Text input-->
                <div class="form-group">
                    <label class="col-md-4 control-label" for="title">Title of Activity</label>  
                    <div class="col-md-4">
                        <input id="title" name="title" type="text" placeholder="" class="form-control input-md" required="">

                    </div>
                </div>

                <!-- Text input-->
                <div class="form-group">
                    <label class="col-md-4 control-label" for="description">Description</label>  
                    <div class="col-md-4">
                        <input id="description" name="description" type="text" placeholder="Limits to 140 characters" class="form-control input-md">

                    </div>
                </div>
                
                <p>
                    What is the action(s) the hero must perform to receive their points? Please check the boxes that  apply.
                </p>

                <!-- Multiple Checkboxes -->
                <div class="form-group">
                    <label class="col-md-4 control-label" for="check_facebook"></label>
                    <div class="col-md-4">
                        <div class="checkbox">
                            <label for="check_facebook-0">
                                <input type="checkbox" name="check_facebook" id="check_facebook-0" value="1">
                                Share on their Facebook
                            </label>
                        </div>
                    </div>
                </div>

                <!-- Text input-->
                <div class="form-group">
                    <label class="col-md-4 control-label" for="facebook_share"></label>  
                    <div class="col-md-4">
                        <input id="facebook_share" name="facebook_share" type="text" placeholder="Write down a fact related to the question you would like the user to share. Limit to 140 characters." class="form-control input-md">

                    </div>
                </div>

                <!-- Multiple Checkboxes -->
                <div class="form-group">
                    <label class="col-md-4 control-label" for="check_newsletter"></label>
                    <div class="col-md-4">
                        <div class="checkbox">
                            <label for="check_newsletter-0">
                                <input type="checkbox" name="check_newsletter" id="check_newsletter-0" value="1">
                                Sign up for Your news letter
                            </label>
                        </div>
                    </div>
                </div>

                <!-- Text input-->
                <div class="form-group">
                    <label class="col-md-4 control-label" for="newsletter_link"></label>  
                    <div class="col-md-4">
                        <input id="newsletter_link" name="newsletter_link" type="text" placeholder="Please enter a link to your newsletter." class="form-control input-md">

                    </div>
                </div>

                <!-- Multiple Checkboxes -->
                <div class="form-group">
                    <label class="col-md-4 control-label" for="check_facebook_page"></label>
                    <div class="col-md-4">
                        <div class="checkbox">
                            <label for="check_facebook_page-0">
                                <input type="checkbox" name="check_facebook_page" id="check_facebook_page-0" value="1">
                                Like our facebook page
                            </label>
                        </div>
                    </div>
                </div>

                <!-- Text input-->
                <div class="form-group">
                    <label class="col-md-4 control-label" for="facebook_page"></label>  
                    <div class="col-md-4">
                        <input id="facebook_page" name="facebook_page" type="text" placeholder="Please enter your facebook page address." class="form-control input-md">

                    </div>
                </div>

                <!-- Multiple Checkboxes -->
                <div class="form-group">
                    <label class="col-md-4 control-label" for="check_calendar"></label>
                    <div class="col-md-4">
                        <div class="checkbox">
                            <label for="check_calendar-0">
                                <input type="checkbox" name="check_calendar" id="check_calendar-0" value="1">
                                Add to User's calendar
                            </label>
                        </div>
                    </div>
                </div>

                <!-- Text input-->
                <div class="form-group">
                    <label class="col-md-4 control-label" for="calendar"></label>  
                    <div class="col-md-4">
                        <input id="calendar" name="calendar" type="text" placeholder="Please select a date" class="form-control input-md">

                    </div>
                </div>

                <!-- Button -->
                <div class="form-group">
                    <label class="col-md-4 control-label" for="submit"></label>
                    <div class="col-md-4">
                        <button id="submit" name="submit" class="btn btn-primary">Submit Activity</button>
                    </div>
                </div>

            </fieldset>
        </form>




    </div><!-- /#page-wrapper -->
</div><!-- /#wrapper -->