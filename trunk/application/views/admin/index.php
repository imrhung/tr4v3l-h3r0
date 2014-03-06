<div class="alert alert-danger alert-dismissable top-alert">
  <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
  <strong>Hi Super Admin!</strong> You are loged in as super admin, this means you're top dogs. So please be aware what you do affect others below you.
</div>

<div id="wrapper">


    <div id="page-wrapper">

        <h1><b>Welcome to Hero for Zero.</b></h1>
        <p>We are excited to introduce to you our new program. Below you will find some link to help you understand our program.</p>
        <div><div class="fload-left">
                <a href="#">
                    <button class="btn btn-large big-btn">How does it all work?</button>
                </a>
            </div>
            <div class="fload-left">
                <a href="#">
                    <input type="image" src="<?php echo base_url() ?>assets/img/download_app_btn.png" name="download-app" class="" id="download-app" />
                </a>
            </div></div>
        <div>
            <br>
            <br>
            <hr class="hr-light-blue">
        </div>

        <!-- Main content -->
        <!-- Quest approval -->
        <h3>Please approve recent quest</h3>
        <p>Below are quests that have been created by other organizations. Please approve or deny them.</p>
        <table class="table table-striped table-bordered">
            <thead>
                <tr>
                    <th>
            <div class="checkbox"> <label> <input type="checkbox">  </label> </div>
            </th>
            <th>Author</th>
            <th>Packet</th>
            <th>Quest Category</th>
            <th>Approve?</th>
            <th>Published</th>
            </tr>
            </thead>
            <tbody>
                <tr>
                    <td>
                        <div class="checkbox"> <label> <input type="checkbox">  </label> </div>
                    </td>
                    <td>Agape Children's Home</td>
                    <td>
                        <select id="packet" name="packet" class="form-control">
                            <option value="1">Ho Chi Minh City</option>
                            <option value="2">Da Nang</option>
                            <option value="3">Ha Noi</option>
                            <option value="4">Nha Trang</option>
                        </select>
                    </td>
                    <td>
                        <select id="category" name="category" class="form-control">
                            <option value="1">Saving Children</option>
                            <option value="2">Donate Time</option>
                            <option value="3">Volunteer</option>
                            <option value="4">Teching</option>
                        </select>
                    </td>
                    <td>
                        <button id="approve" name="approve" class="btn btn-success">Yes</button>
                        <button id="deny" name="deny" class="btn btn-danger">No</button>
                    </td>
                    <td>2014/03/06</td>
                </tr>
                <tr>
                    <td></td>
                    <td>KOTO</td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td>-</td>
                </tr>
                <tr>
                    <td></td>
                    <td>SOZO</td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td>-</td>
                </tr>
                <tr>
                    <td></td>
                    <td>365.ORG</td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td>-</td>
                </tr>
                <tr>
                    <td></td>
                    <td>Unicef next Generation</td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td>-</td>
                </tr>
                <tr>
                    <td></td>
                    <td>Kristina Nobel Foundation</td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td>-</td>
                </tr>
                <tr>
                    <td></td>
                    <td>Bill and Mellinda Foundation</td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td>-</td>
                </tr>
            </tbody>
        </table>

        <!-- Activity approval -->
        <h3>Please approve recent activity</h3>
        <p>Below are activities that have been created by other organizations. Please approve or deny them.</p>

        <table class="table table-striped table-bordered">
            <thead>
                <tr>
                    <th>
            <div class="checkbox"> <label> <input type="checkbox">  </label> </div>
            </th>
            <th>Title of Activity</th>
            <th>Author</th>
            <th>Point Value</th>
            <th>Approve?</th>
            <th>Published</th>
            </tr>
            </thead>
            <tbody>
                <tr>
                    <td>
                        <div class="checkbox"> <label> <input type="checkbox">  </label> </div>
                    </td>
                    <td>Join NextGen Unicef</td>
                    <td>
                        NextGen Unicef
                    </td>
                    <td>
                        <select id="category" name="category" class="form-control">
                            <option value="1">100pts</option>
                            <option value="2">200pts</option>
                            <option value="3">300pts</option>
                            <option value="4">400pts</option>
                        </select>
                    </td>
                    <td>
                        <button id="approve" name="approve" class="btn btn-success">Yes</button>
                        <button id="deny" name="deny" class="btn btn-danger">No</button>
                    </td>
                    <td>2014/03/06</td>
                </tr>
                <tr>
                    <td>
                        <div class="checkbox"> <label> <input type="checkbox">  </label> </div>
                    </td>
                    <td>Sign up for newsletter</td>
                    <td>KOTO</td>
                    <td>
                        <select id="category" name="category" class="form-control">
                            <option value="1">100pts</option>
                            <option value="2">200pts</option>
                            <option value="3">300pts</option>
                            <option value="4">400pts</option>
                        </select>
                    </td>
                    <td>2014/03/06</td>
                    <td>2014/03/06</td>
                </tr>
            </tbody>
        </table>
        
        <!-- Donation approval -->
        <h3>Please approve recent Donation suggestions</h3>
        <p>Below are Donation suggestions that have been created by other organizations. Please approve or deny them.</p>

        <table class="table table-striped table-bordered">
            <thead>
                <tr>
                    <th>
            <div class="checkbox"> <label> <input type="checkbox">  </label> </div>
            </th>
            <th>Title of Donation</th>
            <th>Author</th>
            <th>Cost</th>
            <th>Approve?</th>
            <th>Published</th>
            </tr>
            </thead>
            <tbody>
                <tr>
                    <td>
                        <div class="checkbox"> <label> <input type="checkbox">  </label> </div>
                    </td>
                    <td>Donation 100 Dollars</td>
                    <td>
                        NextGen Unicef
                    </td>
                    <td>
                        <select id="category" name="category" class="form-control">
                            <option value="1">100pts</option>
                            <option value="2">200pts</option>
                            <option value="3">300pts</option>
                            <option value="4">400pts</option>
                        </select>
                    </td>
                    <td>
                        <button id="approve" name="approve" class="btn btn-success">Yes</button>
                        <button id="deny" name="deny" class="btn btn-danger">No</button>
                    </td>
                    <td>2014/03/06</td>
                </tr>
                <tr>
                    <td>
                        <div class="checkbox"> <label> <input type="checkbox">  </label> </div>
                    </td>
                    <td>Donate 3 box of books</td>
                    <td>KOTO</td>
                    <td>
                        <select id="category" name="category" class="form-control">
                            <option value="1">100pts</option>
                            <option value="2">200pts</option>
                            <option value="3">300pts</option>
                            <option value="4">400pts</option>
                        </select>
                    </td>
                    <td>2014/03/06</td>
                    <td>2014/03/06</td>
                </tr>
            </tbody>
        </table>

    </div><!-- /#page-wrapper -->
</div><!-- /#wrapper -->