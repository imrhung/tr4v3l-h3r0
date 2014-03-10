$(document).ready(function(){
    $("#submit").click(function(){
        
        var baseUrl = window.location.protocol + "//" +window.location.host +"/";
        console.log(baseUrl);
        var username = $("#username").val();
        var password = $("#password").val();
        var name = $("#name").val();
        var admin= $("#admin_name").val();
        var email = $("#email").val();
        var address = $("#address").val();
        var phone = $("#phone").val();
        var website = $("#website").val();
        var type = $("#type").val();
        var description= $("#description").val();
        
        if (username==""||password==""||name==""||email==""){
            // We can do some input validation here. :D
            $("div#ack").html("Please fill out your information.");
        }else {
            // Make the spining when waiting for signup.
            
            // Post to signup api
            $.post(
            baseUrl+"admin/testapi_s",
            {
                username: username,
                password: password,
                name : name,
                admin: admin,
                email: email,
                address: address,
                phone: phone,
                website: website,
                type: type,
                description: description,
            },
            function(data){
                if (data.code == 1){ // Successful
                    
                    // Store session
                    
                    // Check the role and redirect
                    
                    // Redirect to admin page
                    window.location.replace(baseUrl + "organization/index");
                } else { // Fail
                    $("div#ack").html("Incorrect username or password. Please try again.");
                }
            },
            "json"
        );
        }
    });
});

