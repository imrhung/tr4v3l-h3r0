<div id="wrapper">

    <div id="page-wrapper">

        <h1>Create Quest</h1>
        <p>Please select the fields below to create a quest.</p>

        <div id="alert_placeholder"></div>
        <form id="quest-form" class="form-horizontal" onSubmit="createQuest(); return false;">
            <fieldset>

                <!-- Form Name -->
                <legend></legend>

                <input type="hidden" name="partner-id" id="partner-id" value="<?php echo $partnerId ?>">
                <!-- Select Basic -->
                <div class="form-group">
                    <label class="col-md-4 control-label" for="packet">Choose Quest Packet</label>
                    <div class="col-md-8" id="select-packet"></div>
                </div>

                <!-- Text input-->
                <div class="form-group">
                    <label class="col-md-4 control-label" for="name">Name</label>  
                    <div class="col-md-8">
                        <input id="name" name="name" type="text" placeholder="Title for the quest" class="form-control input-md" required="">

                    </div>
                </div>
                
                <!-- Text input-->
                <div class="form-group">
                    <label class="col-md-4 control-label" for="unlock">Unlock Point</label>  
                    <div class="col-md-8">
                        <input id="unlock" name="unlock" type="text" placeholder="Amount of points user must have to unlock this quest." class="form-control input-md" required="">
                        
                    </div>
                </div>

                <!-- Text input-->
                <div class="form-group">
                    <label class="col-md-4 control-label" for="point">Point to Advance</label>  
                    <div class="col-md-8">
                        <input id="point" name="point" type="text" placeholder="Amount of points user must earn to complete the quest." class="form-control input-md" required="">
                        
                    </div>
                </div>

                <!-- Select Basic -->
                <div class="form-group">
                    <label class="col-md-4 control-label" for="category">Quiz Category</label>
                    <div class="col-md-8" id="select-category">
                    </div>
                </div>

                <!-- Select Basic -->
                <div class="form-group">
                    <label class="col-md-4 control-label" for="activity_1">Choose the Activity</label>
                    <div class="col-md-8" id="select-activity-1">
                    </div>
                </div>

                <!-- Select Basic -->
                <div class="form-group">
                    <label class="col-md-4 control-label" for="activity_2"></label>
                    <div class="col-md-8" id="select-activity-2">
                    </div>
                </div>

                <!-- Select Basic -->
                <div class="form-group">
                    <label class="col-md-4 control-label" for="activity_3"></label>
                    <div class="col-md-8" id="select-activity-3">
                    </div>
                </div>

                <!-- Select Basic -->
                <div class="form-group">
                    <label class="col-md-4 control-label" for="donation_1">Choose Donation</label>
                    <div class="col-md-8" id="select-donation-1">
                    </div>
                </div>

                <!-- Select Basic -->
                <div class="form-group">
                    <label class="col-md-4 control-label" for="donation_2"></label>
                    <div class="col-md-8" id="select-donation-2">
                    </div>
                </div>

                <!-- Select Basic -->
                <div class="form-group">
                    <label class="col-md-4 control-label" for="donation"></label>
                    <div class="col-md-8" id="select-donation-3">
                    </div>
                </div>

                <!-- Button -->
                <div class="form-group">
                    <label class="col-md-4 control-label" for="submit"></label>
                    <div class="col-md-8">
                        <button id="submit" name="submit" class="btn btn-primary">Add Quest</button>
                        
                    </div>
                </div>

            </fieldset>
        </form>


    </div><!-- /#page-wrapper -->
</div><!-- /#wrapper -->