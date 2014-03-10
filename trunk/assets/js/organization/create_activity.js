function createActivity() {
    var baseUrl = window.location.protocol + "//" + window.location.host + "/";

    // Get the input data:
    var partner_id = 1;
    var title = $("#title").val();
    var description = $("#description").val();
    var check_facebook = (document.getElementById("check_facebook").checked) ? 1 : 0;
    var facebook_share = $("#facebook_share").val();
    var check_newsletter = (document.getElementById("check_newsletter").checked) ? 1 : 0;
    var newsletter_link = $("#newsletter_link").val();
    var check_facebook_page = (document.getElementById("check_facebook_page").checked) ? 1 : 0;
    var facebook_page = $("#facebook_page").val();
    var check_calendar = (document.getElementById("check_calendar").checked) ? 1 : 0;
    var calendar = $("#calendar").val();
    
    // Make the spining when waiting
    
    // Post to api
    $.post(
            baseUrl + "admin/testapi_s",
            {
                partner_id: partner_id,
                title: title,
                description: description,
                check_facebook: check_facebook,
                facebook_share: facebook_share,
                check_newsletter: check_newsletter,
                newsletter_link: newsletter_link,
                check_facebook_page: check_facebook_page,
                facebook_page: facebook_page,
                check_calendar: check_calendar,
                calendar: calendar,
                //password: password
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
                }
            },
            "json"
        );

    console.log("he");
    return false;
}

successfulAlert = function(message) {
    var baseUrl = window.location.protocol + "//" + window.location.host + "/";
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
