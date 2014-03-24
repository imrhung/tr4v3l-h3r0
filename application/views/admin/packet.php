<div id="wrapper">

    <div id="page-wrapper">

        <h1>Packet and Category</h1>
        <p>Each quest must belong to a city or a packet. You must first create that city or packet, then you can associate that packet/city with your quest.</p>

        
        
        <!-- Left table -->
        <div class="col-md-6">
            <table class="table table-striped table-bordered" id="packet-table">
                <thead>
                    <tr>
                        <th>Packet's Name</th>
                        <th>Packet's Background</th>
                    </tr>
                </thead>
                <tbody>
                    
                </tbody>
            </table>
            <form class='form-inline' role ='form' onsubmit="createPacket(); return false;">
                <div class='form-group col-md-6'>
                    <label class='sr-only' for='packet'>Packet's Name</label>
                    <input type='text' class='form-control' id='packet' placeholder='Write the packet name' required="">
                </div>
                <div class='col-md-6'>
                    <button type='submit' class='btn btn-block btn-primary'>Add Packet</button>
                </div>
            </form>
        </div> <!-- #End of Left table -->

        <!-- Right table -->
        <div class='col-md-6'>
            <table class="table table-striped table-bordered" id="category-table">
                <thead>
                    <tr>
                        <th>Quest Category</th>
                        <th>Category's ID</th>
                    </tr>
                </thead>
                <tbody>
                    
                </tbody>
            </table>
            <form class='form-inline' role ='form' onsubmit="createCategory(); return false;">
                <div class='form-group col-md-6'>
                    <label class='sr-only' for='category'>Category's Name</label>
                    <input type='text' class='form-control' id='category' placeholder='Write the category name' required="">
                </div>
                <div class='col-md-6'>
                    <button type='submit' class='btn btn-block btn-primary'>Add Category</button>
                </div>
            </form>
        </div> <!-- #End of Right table -->


    </div><!-- /#page-wrapper -->
</div><!-- /#wrapper -->