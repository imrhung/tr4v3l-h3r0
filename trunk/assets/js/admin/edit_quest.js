// global variable:
var partnerId = 0;

function getQuest(questId) {
    //var baseUrl = window.location.protocol + "//" + window.location.host + "/";
    var baseUrl = $("#base-url").attr("href");
    // Make the spining when waiting
    // Disable submit button

    // Post to api
    $.post(
            baseUrl + "virtualquest/getVirtualQuest",
            {
                id: questId
            },
            function(data) {
                console.log(data);
                if (data.code === 1) { // Successful
                    var quest = data.info.quest;
                    $('#packet').val(quest.PacketId);
                    $('#name').val(quest.QuestName);
                    $('#point').val(quest.UnlockPoint);
                    var condition = data.info.condition;
                    var selectActivity = 0;
                    var selectDonation = 0;
                    for (var i=0; i<condition.length; i++){
                        if (condition[i].Type == 1){ // Activity
                            switch (selectActivity){
                                case 0:
                                    $('#activity_1').val(condition[i].ObjectId);
                                    break;
                                case 1:
                                    $('#activity_2').val(condition[i].ObjectId);
                                    break;
                                case 2:
                                    $('#activity_3').val(condition[i].ObjectId);
                                    break;
                                default:
                                    $('#activity_1').val(condition[i].ObjectId);
                            }
                            selectActivity++;
                        } else { // Donation
                            switch (selectDonation){
                                case 0:
                                    $('#donation_1').val(condition[i].ObjectId);
                                    break;
                                case 1:
                                    $('#donation_2').val(condition[i].ObjectId);
                                    break;
                                case 2:
                                    $('#donation_3').val(condition[i].ObjectId);
                                    break;
                                default:
                                    $('#donation_1').val(condition[i].ObjectId);
                            }
                            selectDonation++;
                        }
                    }
                    
                } else { // Fail

                }
            },
            "json"
            );
}


function updateQuest(questId){
    //var baseUrl = window.location.protocol + "//" + window.location.host + "/";
    var baseUrl = $("#base-url").attr("href");

    // Get the input data:
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
    
    // Post to api
    $.post(
            baseUrl + "virtualquest/updateVirtualQuest",
            {
                id: questId,
                partner_id: partnerId,
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
                    successfulAlert("Your Quest has been updated!");
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

function callDeleteQuest(questId){
    bootbox.confirm(
            "Are you sure you want to delete this Quest. The action cannot be undone!",
            function(result){
                if (result){
                    deleteQuest(questId);
                }
            }
        );
}

function deleteQuest(questId){
    var baseUrl = $("#base-url").attr("href");
    console.log("Deleting");
    // Make the spining when waiting
    // Disable submit button

    // Post to api
    $.post(
            baseUrl + "virtualquest/deleteVirtualQuest",
            {
                id: questId,
            },
            function(data) {
                console.log(data);
                if (data.code === 1) { // Successful
                    bootbox.alert("Delete successfuly! Come back to home page!", 
                        function(){
                            window.location.replace(baseUrl + "admin/index");
                        });
                } else { // Fail
                    bootbox.alert("Some error happened that we cannot delete. Please try again later.", 
                        function(){
                            
                        });
                }
            },
            "json"
            );
}

successfulAlert = function(message) {
    var baseUrl = $("#base-url").attr("href");
    $('#alert_placeholder').html('<div class="alert alert-success alert-dismissable"><button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button><span>' + message + '</span> </div>')
}

function draw(questId){
    drawSelectPacket();
    drawSelectCategory();
    drawSelectActivity();
    drawSelectDonation(questId);
}

function drawSelectPacket(){
    var baseUrl = $("#base-url").attr("href");
    
    // Post to api
    $.post(
            baseUrl + "packet/getPacketList",
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
            baseUrl + "activity/getActivityList",
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

function drawSelectDonation(questId){
    var baseUrl = $("#base-url").attr("href");
    
    // Post to api
    $.post(
            baseUrl + "donation/getDonationList",
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
                    
                    getQuest(questId);
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
            baseUrl + "quizcategory/getQuizCategoryList",
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