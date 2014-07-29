<div id="wrapper">

    <div id="page-wrapper">

        <h1>Create a Quest</h1>
        <p>Please select the fields below to create a quest.</p>

        <div id="alert_placeholder"></div>
        <div class="col-lg-8">
        <form id="quest-form" class="form-horizontal" role="form" onsubmit="return false;">
            <fieldset>

                <!-- Form Name -->
                <legend></legend>

                <input type="hidden" name="partner-id" id="partner-id" value="<?php echo $partnerId ?>">
                <input type="hidden" name="quest-id" id="quest-id" value="<?php echo $questId ?>">
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
  <label class="col-md-4 control-label" for="animation">Animation</label>
  <div class="col-md-8">
    <select id="animation" name="animation" class="form-control image-picker">
        <option data-img-src="<?php echo base_url() ?>assets/img/animation/1.png" value="1">Animation 1</option>
        <option data-img-src="<?php echo base_url() ?>assets/img/animation/2.png" value="2">Animation 2</option>
        <option data-img-src="<?php echo base_url() ?>assets/img/animation/3.png" value="3">Animation 3</option>
        <option data-img-src="<?php echo base_url() ?>assets/img/animation/4.png" value="4">Animation 4</option>
    </select>
  </div>
</div>
                <!-- Select Basic -->
<div class="form-group">
  <label class="col-md-4 control-label" for="character">Quest character</label>
  <div class="col-md-8">
    <select id="character" name="character" class="form-control">
        <option data-img-src="<?php echo base_url() ?>assets/img/quest/1.png" value="<?php echo base_url() ?>assets/img/quest/1.png">Nhi</option>
        <option data-img-src="<?php echo base_url() ?>assets/img/quest/2.png" value="<?php echo base_url() ?>assets/img/quest/2.png">Han</option>
        <option data-img-src="<?php echo base_url() ?>assets/img/quest/3.png" value="<?php echo base_url() ?>assets/img/quest/3.png">My</option>
        <option data-img-src="<?php echo base_url() ?>assets/img/quest/4.png" value="<?php echo base_url() ?>assets/img/quest/4.png">Nam</option>
        <option data-img-src="<?php echo base_url() ?>assets/img/quest/training-activity@2x.png" value="<?php echo base_url() ?>assets/img/quest/training-activity@2x.png">Activity</option>
        <option data-img-src="<?php echo base_url() ?>assets/img/quest/training-award@2x.png" value="<?php echo base_url() ?>assets/img/quest/training-award@2x.png">Donation</option>
        <option data-img-src="<?php echo base_url() ?>assets/img/quest/training-quiz@2x.png" value="<?php echo base_url() ?>assets/img/quest/training-quiz@2x.png">Quiz</option>
      
    </select>
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
                        <button id="submit" name="submit" class="btn btn-primary">Submit</button>
                        
                    </div>
                </div>

            </fieldset>
        </form>
        </div>
        
        <?php if ($edit_quest) : ?>
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
        <?php endif; ?>


    </div><!-- /#page-wrapper -->
</div><!-- /#wrapper -->