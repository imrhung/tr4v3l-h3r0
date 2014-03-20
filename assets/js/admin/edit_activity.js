// global variable:
var approve = 0;

function getActivity(activityId) {
    //var baseUrl = window.location.protocol + "//" + window.location.host + "/";
    var baseUrl = $("#base-url").attr("href");
    // Make the spining when waiting
    // Disable submit button

    // Post to api
    $.post(
            baseUrl + "admin/getActivity",
            {
                id: activityId
            },
            function(data) {
                console.log(data);
                if (data.code === 1) { // Successful
                    
                    // Update the first form
                    $('#partner-id').val(data.info.activity.PartnerId);
                    $('#title').val(data.info.activity.Title);
                    $('#description').val(data.info.activity.Description);
                    
                    // Base on action id to set content.
                     var $radios = $('input:radio[name=action]');
                    switch (data.info.activity.ActionId){
                        case 0:
                            $('#facebook_share').val(data.info.activity.ActionContent);
                            $radios.filter('[value=0]').prop('checked', true);
                            break;
                        case 1: 
                            $('#newsletter_link').val(data.info.activity.ActionContent);
                            $radios.filter('[value=1]').prop('checked', true);
                            break;
                        case 2:
                            $('#facebook_page').val(data.info.activity.ActionContent);
                            $radios.filter('[value=2]').prop('checked', true);
                            break;
                        case 3:
                            $('#calendar').val(data.info.activity.ActionContent);
                            $radios.filter('[value=3]').prop('checked', true);
                            break;
                        default:
                            $('#facebook_share').val(data.info.activity.ActionContent);
                            $radios.filter('[value=0]').prop('checked', true);
                    }
                    
                    $('#point').val(data.info.activity.BonusPoint);
                    if (data.info.activity.IsApproved === 1){
                        $('div#approve-activity').html('Yes');
                        approve = 1;
                    }
                } else { // Fail

                }
            },
            "json"
            );
}


function updateActivity(activityId){
    //var baseUrl = window.location.protocol + "//" + window.location.host + "/";
    var baseUrl = $("#base-url").attr("href");

    // Get the input data:
    var partner_id = $("#partner-id").val();
    var title = $("#title").val();
    var description = $("#description").val();
    var actionId = parseInt($("input[name='action']:checked", '#activity-form').val());
    var actionContent='';
    switch (actionId){
        case 0:
            actionContent = $('#facebook_share').val();
            break;
        case 1:
            actionContent = $('#newsletter_link').val();
            break;
        case 2:
            actionContent = $('#facebook_page').val();
            break;
        case 3:
            actionContent = $('#calendar').val();
            break;
        default:
            actionContent = $('#facebook_share').val();
    }
    var point = $('#point').val();
    
    // Make the spining when waiting
    // Disable submit button
    
    // Post to api
    $.post(
            baseUrl + "admin/testapi_s",
            {
                id: activityId,
                partner_id: partner_id,
                title: title,
                description: description,
                action_id: actionId,
                action_content: actionContent,
                point: point,
                approve: approve
            },
            function(data) {
                console.log(data);
                if (data.code == 1) { // Successful
                    successfulAlert("Your activity has been updated!");
                    return false;
                } else { // Fail
                    bootstrap_alert.warning("Some error occurred, please try again!");
                }
            },
            "json"
        );
    return false;
}

function callDeleteAct(activityId){
    bootbox.confirm(
            "Are you sure you want to delete this Activity. The action cannot be undone!",
            function(result){
                if (result){
                    deleteActivity(activityId);
                }
            }
        );
}

function deleteActivity(activityId){
    var baseUrl = $("#base-url").attr("href");
    console.log("Deleting");
    // Make the spining when waiting
    // Disable submit button

    // Post to api
    $.post(
            baseUrl + "admin/testapi",
            {
                id: activityId,
            },
            function(data) {
                console.log(data);
                if (data.code === 1) { // Successful
                    bootbox.alert("Delete successfuly! Come back to home page!", 
                        function(){
                            window.location.replace(baseUrl + "admin/index");
                        });
                } else { // Fail
                    bootbox.alert("Some error happened that we cannot delete the quest. Please try again later.", 
                        function(){
                            
                        });
                }
            },
            "json"
            );
}

function approveActivity(activityId, state){
    var baseUrl = $("#base-url").attr("href");
    
    // Make the spining when waiting
    // Disable submit button

    // Post to api
    $.post(
            baseUrl + "admin/testapi",
            {
                id: activityId,
                state: state
            },
            function(data) {
                console.log(data);
                if (data.code === 1) { // Successful
                    
                } else { // Fail

                }
            },
            "json"
            );
}

successfulAlert = function(message) {
    var baseUrl = $("#base-url").attr("href");
    $('#alert_placeholder').html('<div class="alert alert-success alert-dismissable"><button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button><span>' + message + '</span> </div>')
}

$(function () {
    $('#datetimepicker').datetimepicker({
        icons: {
            time: "fa fa-clock-o",
            date: "fa fa-calendar",
            up: "fa fa-arrow-up",
            down: "fa fa-arrow-down"
        },
        pickTime: false,
        useStrict: true,
    });
});