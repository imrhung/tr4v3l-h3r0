<div id="wrapper">

    <div id="page-wrapper">

        <h1>Edit Quest</h1>
        <p>Edit quest information.</p>

        <div id="alert_placeholder"></div>
        <div class="col-lg-8">
            <form id="quest-form" class="form-horizontal" onSubmit="updateQuest(<?php echo $questId?>);
                    return false;">
                <fieldset>

                    <!-- Form Name -->
                    <legend></legend>
                    
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
                            <input id="point" name="point" type="text" placeholder="Amount of points user must earn to advance to the next quest." class="form-control input-md" required="">

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
                            <button id="submit" name="submit" class="btn btn-primary">Update Quest</button>
                        </div>
                    </div>
                </fieldset>
            </form>
        </div>



        <div class="col-lg-4 left-border">
            <form class="" role="form">
                <fieldset>

                    <!-- Form Name -->
                    <legend></legend>

                    <!-- Button -->
                    <div class="form-group">
                        <label class="control-label" for="delete"></label>
                        <div class="col-md-12">
                            <button type="button" id="delete" name="delete" class="btn btn-danger btn-block" onclick="callDeleteQuest(<?php echo $questId ?>)"> Delete Quest</button>
                        </div>
                    </div>

                </fieldset>
            </form>
        </div>



    </div><!-- /#page-wrapper -->
</div><!-- /#wrapper -->

<script>
    $(function() {
        draw(<?php echo $questId; ?>);
    });
</script>