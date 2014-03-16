function createActivity() {
    //var baseUrl = window.location.protocol + "//" + window.location.host + "/";
    var baseUrl = $("#base-url").attr("href");

    // Get the input data:
    var partner_id = 1;
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
    
    // Make the spining when waiting
    // Disable submit button
    $('#submit').attr('disabled', 'true');
    
    // Post to api
    $.post(
            baseUrl + "admin/testapi_s",
            {
                partner_id: partner_id,
                title: title,
                description: description,
                action_id: actionId,
                action_content: actionContent
            },
            function(data) {
                console.log(data);
                if (data.code == 1) { // Successful

                    // Store session

                    // Check the role and redirect

                    // Redirect to admin page
                    //return false;
                    successfulAlert("Your activity has been created successfully. Do you want to ");
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
    $('#alert_placeholder').html('<div class="alert alert-success alert-dismissable"><button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button><span>' + message + '</span> <a href="'+baseUrl+'organization/create_activity">Create another Activity</a></div>')
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
