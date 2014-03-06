<div id="wrapper">


    <div id="page-wrapper">

        <div class="row">
            <div class="col-lg-12">
                <h1>Partner Form <small>Enter Your Data</small></h1>
                <ol class="breadcrumb">
                    <li><a href="index.php"><i class="fa fa-dashboard"></i> Dashboard</a></li>
                    <li class="active"><i class="fa fa-edit"></i> Partner Form</li>
                </ol>
            </div>
        </div>

        <div class="row">

            <div class="col-lg-6">
                <h1>Partner Info</h1>
                <form id="partner_form">
                    <!--<div class="form-group">
                            <label>Photo upload</label>
                            <input type="file" class="form-control" size="32" name="my_field" value="" />
                            <p class="help-block">Max file size 1MB.</p>
                            <input type="hidden" name="action" value="simple" />
                            <input id="button" type="submit" value="Upload" class="btn btn-primary">
                    </div>-->
                    <div class="form-group">
                        <label>Organization's Name</label>
                        <input type="text" class="form-control" id="organizationName" name="organizationName" value="" />
                    </div>
                    <div class="form-group">
                        <label>Phone Number</label>
                        <input type="text" class="form-control" id="phone" name="phone" value="" />
                    </div>
                    <label>Address</label>
                    <div class="form-group input-group">
                        <input type="text" class="form-control" id="address" name="address"/>
                        <span class="input-group-btn">
                            <button class="btn btn-default" type="button" id=""><i class="fa fa-search"></i></button>
                        </span>
                    </div>
                    <div class="form-group">
                        <label>Description</label>
                        <textarea rows="4" cols="50" class="form-control" id="desc" name="desc"></textarea> 
                    </div>
                    <input id="button" type="submit" value="Submit" class="btn btn-primary">
                    <div id="fp_message"></div>
                </form>
            </div>

            <div class="col-lg-6">
                <h1>Questions</h1>
                <div class="form-group">
                    <label>Question</label>
                    <textarea rows="4" cols="50" class="form-control" id="" name=""></textarea> 
                </div>
                <h3>Answers</h3>
                <div class="form-group input-group">
                    <span class="input-group-addon">A</span>
                    <input type="text" class="form-control" placeholder="Answer A">
                </div>
                <div class="form-group input-group">
                    <span class="input-group-addon">B</span>
                    <input type="text" class="form-control" placeholder="Answer B">
                </div>
                <div class="form-group input-group">
                    <span class="input-group-addon">C</span>
                    <input type="text" class="form-control" placeholder="Answer C">
                </div>
                <div class="form-group input-group">
                    <span class="input-group-addon">D</span>
                    <input type="text" class="form-control" placeholder="Answer D">
                </div>
            </div>

        </div><!-- /#row -->
    </div><!-- /#page-wrapper -->
</div><!-- /#wrapper -->