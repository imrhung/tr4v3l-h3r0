<div id="wrapper">

    <div id="page-wrapper">

        <h1>Create Donation</h1>
        <p>To Create a Donation please fill out the information below.</p>

        <form class="form-horizontal" onSubmit="return createDonation();">
            <fieldset>
                
                <!-- Form Name -->
                <legend></legend>

                <!-- Text input-->
                <div class="form-group">
                    <label class="col-md-4 control-label" for="title">Title of Donation</label>  
                    <div class="col-md-8">
                        <input id="title" name="title" type="text" placeholder="" class="form-control input-md" required="">

                    </div>
                </div>

                 <!-- Textarea -->
<div class="form-group">
  <label class="col-md-4 control-label" for="description">Description</label>
  <div class="col-md-8">                     
    <textarea class="form-control" id="description" name="description"></textarea>
  </div>
</div>

                <!-- Button -->
                <div class="form-group">
                    <label class="col-md-4 control-label" for="submit"></label>
                    <div class="col-md-4">
                        <button id="submit" name="submit" class="btn btn-primary">Submit Donation</button>
                        <div id="alert_placeholder"></div>
                    </div>
                </div>

            </fieldset>
        </form>

    </div><!-- /#page-wrapper -->
</div><!-- /#wrapper -->