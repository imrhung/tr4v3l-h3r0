$(function (){
    drawSelectCategory();
});


function createQuiz() {
    //var baseUrl = window.location.protocol + "//" + window.location.host + "/";
    var baseUrl = $("#base-url").attr("href");

    // Get the input data:
    // TODO : partner ID
    var partner_id = $("#partner-id").val();
    var category = $("#category").val();
    var question = $("#question").val();
    var answer_a = $("#answer_a").val();
    var answer_b = $("#answer_b").val();
    var answer_c = $("#answer_c").val();
    var answer_d = $("#answer_d").val();
    var correct_answer = $("input[name='answer']:checked", '#quiz-form').val();
    var sharing = $("#sharing").val();
    var link = $("#link").val();
    
    // Make the spining when waiting
    // Disable submit button
    $('#submit').attr('disabled', 'true');
    
    // Post to api
    $.post(
            baseUrl + "quiz/insertQuiz",
            {
                partner_id: partner_id,
                category: category,
                question: question,
                answer_a: answer_a,
                answer_b: answer_b,
                answer_c: answer_c,
                answer_d: answer_d,
                correct_answer: correct_answer,
                sharing: sharing,
                link: link
            },
            function(data) {
                console.log(data);
                if (data.code == 1) { // Successful

                    // Store session

                    // Check the role and redirect

                    // Redirect to admin page
                    //return false;
                    successfulAlert("Your Quiz has been created successfully. Do you want to ");
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
    $('#alert_placeholder').html('<div class="alert alert-success alert-dismissable"><button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button><span>' + message + '</span> <a href="'+baseUrl+'organization/create_quiz">Create another Quiz</a></div>')
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
