<div id="wrapper">

    <div id="page-wrapper">

        <h1>Create Donation</h1>
        <p>Each quest must belong to a city or a packet. You must first create that city or packet, then you can associate that packet/city with your quest.</p>

        
        
        <!-- Left table -->
        <div class="col-md-6">
            <table class="table table-striped table-bordered" id="packet-table">
                <thead>
                    <tr>
                        <th>Packet's Name</th>
                        <th>Packet's ID</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>Can Tho</td>
                        <td>1</td>
                    </tr>
                    <tr>
                        <td>Vung Tau</td>
                        <td>2</td>
                    </tr>
                    <tr>
                        <td>Ho Chi Minh City</td>
                        <td>3</td>
                    </tr>
                    <tr>
                        <td>Da Nang</td>
                        <td>4</td>
                    </tr>
                    <tr>
                        <td>Nha Trang</td>
                        <td>5</td>
                    </tr>
                    
                </tbody>
            </table>
            <form class='form-inline' role ='form'>
                <div class='form-group col-md-6'>
                    <label class='sr-only' for='packet'>Packet's Name</label>
                    <input type='text' class='form-control' id='packet' placeholder='Write the packet name'>
                </div>
                <div class='col-md-6'>
                    <button type='submit' class='btn btn-block btn-primary'>Add Packet</button>
                </div>
            </form>
        </div> <!-- #End of Left table -->

        <!-- Right table -->
        <div class='col-md-6'>
            <table class="table table-striped table-bordered">
                <thead>
                    <tr>
                        <th>Quest Category</th>
                        <th>Category's ID</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>Helping Children</td>
                        <td>11</td>
                    </tr>
                    <tr>
                        <td>Giving Food</td>
                        <td>21</td>
                    </tr>
                    <tr>
                        <td>Donating time</td>
                        <td>31</td>
                    </tr>
                    <tr>
                        <td>Health Care</td>
                        <td>41</td>
                    </tr>
                    <tr>
                        <td>Donation</td>
                        <td>51</td>
                    </tr>
                </tbody>
            </table>
            <form class='form-inline' role ='form'>
                <div class='form-group col-md-6'>
                    <label class='sr-only' for='category'>Category's Name</label>
                    <input type='text' class='form-control' id='category' placeholder='Write the category name'>
                </div>
                <div class='col-md-6'>
                    <button type='submit' class='btn btn-block btn-primary'>Add Category</button>
                </div>
            </form>
        </div> <!-- #End of Right table -->


    </div><!-- /#page-wrapper -->
</div><!-- /#wrapper -->