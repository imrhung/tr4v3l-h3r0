$(document).ready(function(){
    $("#login").click(function(){
        // We can do some input validation here. :D
        var baseUrl = window.location.protocol + "//" +window.location.host +"/";
        console.log(baseUrl);
        var username = $("#username").val();
        var password = $("#password").val();
        if (username==""||password==""){
            $("div#ack").html("Please enter your username and password.");
        }else {
            // Make the spining when waiting for login.
            
            // Post to login api
            $.post(
            baseUrl+"admin/testapi_s",
            {
                username: username,
                password: password
            },
            function(data){
                if (data.code == 1){ // Successful
                    
                    // Store session
                    
                    // Check the role and redirect
                    
                    // Redirect to admin page
                    window.location.replace(baseUrl + "admin/index");
                } else { // Fail
                    $("div#ack").html("Incorrect username or password. Please try again.");
                }
            },
            "json"
        );
        }
    });
});

