$(document).ready(function(){
    drawSelectPacket();
    drawSelectCategory();
    drawSelectActivity();
    drawSelectDonation();
});

function drawSelectPacket(){
    var baseUrl = $("#base-url").attr("href");
    
    // Post to api
    $.post(
            baseUrl + "admin/testPackets",
            {
                pageSize: 0,
                pageNumber: 0
            },
            function(data) {
                console.log(data);
                if (data.code == 1) { // Successful
                    var packets = data.info.packet;
                    var select = $('<select id="packet" name="packet" class="form-control">').appendTo('#select-packet');
                    for (var i=0; i<packets.length; i++){
                        select.append($("<option>").attr('value', packets[i].Id).text(packets[i].Title));
                    }
                } else { // Fail
                    
                }
            },
            "json"
        );
}

function drawSelectActivity(){
    var baseUrl = $("#base-url").attr("href");
    
    // Post to api
    $.post(
            baseUrl + "admin/testactivity",
            {
                pageSize: 0,
                pageNumber: 0
            },
            function(data) {
                console.log(data);
                if (data.code == 1) { // Successful
                    var activity = data.info.activity;
                    var select1 = $('<select id="activity_1" name="activity_1" class="form-control">').appendTo('#select-activity-1');
                    var select2 = $('<select id="activity_2" name="activity_2" class="form-control">').appendTo('#select-activity-2');
                    var select3 = $('<select id="activity_3" name="activity_3" class="form-control">').appendTo('#select-activity-3');
                    select1.append($("<option>").attr('value', 0).text('Select the Activity'));
                    select2.append($("<option>").attr('value', 0).text('Select the Activity'));
                    select3.append($("<option>").attr('value', 0).text('Select the Activity'));
                    for (var i=0; i<activity.length; i++){
                        select1.append($("<option>").attr('value', activity[i].Id).text(activity[i].Title));
                        select2.append($("<option>").attr('value', activity[i].Id).text(activity[i].Title));
                        select3.append($("<option>").attr('value', activity[i].Id).text(activity[i].Title));
                    }
                } else { // Fail
                    
                }
            },
            "json"
        );
}

function drawSelectDonation(){
    var baseUrl = $("#base-url").attr("href");
    
    // Post to api
    $.post(
            baseUrl + "admin/testDonation",
            {
                pageSize: 0,
                pageNumber: 0
            },
            function(data) {
                console.log(data);
                if (data.code == 1) { // Successful
                    var donation = data.info.donation;
                    var select1 = $('<select id="donation_1" name="donation_1" class="form-control">').appendTo('#select-donation-1');
                    var select2 = $('<select id="donation_2" name="donation_2" class="form-control">').appendTo('#select-donation-2');
                    var select3 = $('<select id="donation_3" name="donation_3" class="form-control">').appendTo('#select-donation-3');
                    select1.append($("<option>").attr('value', 0).text('Select the Donation'));
                    select2.append($("<option>").attr('value', 0).text('Select the Donation'));
                    select3.append($("<option>").attr('value', 0).text('Select the Donation'));
                    for (var i=0; i<donation.length; i++){
                        select1.append($("<option>").attr('value', donation[i].Id).text(donation[i].Title));
                        select2.append($("<option>").attr('value', donation[i].Id).text(donation[i].Title));
                        select3.append($("<option>").attr('value', donation[i].Id).text(donation[i].Title));
                    }
                } else { // Fail
                    
                }
            },
            "json"
        );
}

function drawSelectCategory(){
    var baseUrl = $("#base-url").attr("href");
    
    // Post to api
    $.post(
            baseUrl + "admin/testCate",
            {
                pageSize: 0,
                pageNumber: 0
            },
            function(data) {
                console.log(data);
                if (data.code == 1) { // Successful
                    var category = data.info.category;
                    var select = $('<select id="category" name="category" class="form-control">').appendTo('#select-category');
                    select.append($("<option>").attr('value', 0).text('Please select a category'));
                    for (var i=0; i<category.length; i++){
                        select.append($("<option>").attr('value', category[i].Id).text(category[i].CategoryName));
                    }
                } else { // Fail
                    
                }
            },
            "json"
        );
}

function createQuest() {
    var baseUrl = $("#base-url").attr("href");

    // Get the input data:
    var partner_id = $("#partner-id").val();
    var packet_id = $("#packet").val();
    var name = $("#name").val();
    var point = $("#point").val();
    var quiz_category = $("#category").val();
    var activity_id_1 = $("#activity_1").val();
    var activity_id_2 = $("#activity_2").val();
    var activity_id_3 = $("#activity_3").val();
    var donation_id_1 = $("#donation_1").val();
    var donation_id_2 = $("#donation_2").val();
    var donation_id_3 = $("#donation_3").val();
    
    // Make the spining when waiting
    // Disable submit button
    $('#submit').attr('disabled', 'true');
    
    // Post to api
    $.post(
            baseUrl + "admin/testapi_s",
            {
                partner_id: partner_id,
                packet_id: packet_id,
                name: name,
                point: point,
                quiz_category: quiz_category,
                activity_id_1: activity_id_1,
                activity_id_2: activity_id_2,
                activity_id_3: activity_id_3,
                donation_id_1: donation_id_1,
                donation_id_2: donation_id_2,
                donation_id_3: donation_id_3
            },
            function(data) {
                console.log(data);
                if (data.code == 1) { // Successful

                    // Store session

                    // Check the role and redirect

                    // Redirect to admin page
                    //return false;
                    successfulAlert("Your Quest has been created successfully. Do you want to ");
                    //window.location.replace(baseUrl + "organization/create_activity");
                    return false;
                } else { // Fail
                    bootstrap_alert.warning("Some error occurred, please try again!");
                    $('#submit').removeAttr("disabled");
                }
            },
            "json"
        );
    return false;
}

successfulAlert = function(message) {
    var baseUrl = $("#base-url").attr("href");
    $('#alert_placeholder').html('<div class="alert alert-success alert-dismissable"><button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button><span>' + message + '</span> <a href="'+baseUrl+'admin/create_quest">Create another Quest</a></div>')
}
