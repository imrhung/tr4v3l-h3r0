function getQuiz(quizId) {
    //var baseUrl = window.location.protocol + "//" + window.location.host + "/";
    var baseUrl = $("#base-url").attr("href");
    // Make the spining when waiting
    // Disable submit button

    // Post to api
    $.post(
            baseUrl + "admin/testapi",
            {
                id: quizId
            },
            function(data) {
                console.log(data);
                if (data.code === 1) { // Successful
                    
                    // Update the first form
                    $('#category').val(data.info.quiz.CategoryId);
                    $('#question').val(data.info.quiz.Content);
                    $('#answer_a').val(data.info.quiz.AnswerA);
                    $('#answer_b').val(data.info.quiz.AnswerB);
                    $('#answer_c').val(data.info.quiz.AnswerC);
                    $('#answer_d').val(data.info.quiz.AnswerD);
                    // Set the correct answer:
                    var $radios = $('input:radio[name=answer]');
                    switch (data.info.quiz.CorrectChoiceId) {
                        case data.info.quiz.AnswerAId:
                            $radios.filter('[value=0]').prop('checked', true);
                            break;
                        case data.info.quiz.AnswerBId:
                            $radios.filter('[value=1]').prop('checked', true);
                            break;
                        case data.info.quiz.AnswerCId:
                            $radios.filter('[value=2]').prop('checked', true);
                            break;
                        case data.info.quiz.AnswerDId:
                            $radios.filter('[value=3]').prop('checked', true);
                            break;
                        default:
                            $radios.filter('[value=0]').prop('checked', true);
                    }
                    $('#sharing').val(data.info.quiz.SharingInfo);
                    $('#link').val(data.info.quiz.LearnMoreURL);
                    
                    // Update the second form:
                    $('#packet').val(data.info.quiz.PacketId);
                    $('#point').val(data.info.quiz.BonusPoint);
                    $('#date').val(data.info.quiz.PublishedDate);
                    if (data.info.quiz.IsApproved ===1){
                        $('#approve').attr('disabled', 'true');
                        $('#deny').removeAttr("disabled");
                    } else {
                        $('#deny').attr('disabled', 'true');
                        $('#approve').removeAttr("disabled");
                    }
                } else { // Fail

                }
            },
            "json"
            );
}


function updateQuiz(quizId){
    var baseUrl = $("#base-url").attr("href");
    
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

    // Post to api
    $.post(
            baseUrl + "admin/testapi",
            {
                id: quizId,
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
                if (data.code === 1) { // Successful
                    
                    // Update the first form
                    $('#category').val(data.info.quiz.CategoryId);
                    $('#question').val(data.info.quiz.Content);
                    $('#answer_a').val(data.info.quiz.AnswerA);
                    $('#answer_b').val(data.info.quiz.AnswerB);
                    $('#answer_c').val(data.info.quiz.AnswerC);
                    $('#answer_d').val(data.info.quiz.AnswerD);
                    // Set the correct answer:
                    var $radios = $('input:radio[name=answer]');
                    switch (data.info.quiz.CorrectChoiceId) {
                        case data.info.quiz.AnswerAId:
                            $radios.filter('[value=0]').prop('checked', true);
                            break;
                        case data.info.quiz.AnswerBId:
                            $radios.filter('[value=1]').prop('checked', true);
                            break;
                        case data.info.quiz.AnswerCId:
                            $radios.filter('[value=2]').prop('checked', true);
                            break;
                        case data.info.quiz.AnswerDId:
                            $radios.filter('[value=3]').prop('checked', true);
                            break;
                        default:
                            $radios.filter('[value=0]').prop('checked', true);
                    }
                    $('#sharing').val(data.info.quiz.SharingInfo);
                    $('#link').val(data.info.quiz.LearnMoreURL);
                    
                    // Update the second form:
                    $('#packet').val(data.info.quiz.PacketId);
                    $('#point').val(data.info.quiz.BonusPoint);
                    $('#date').val(data.info.quiz.PublishedDate);
                } else { // Fail

                }
            },
            "json"
            );
}

function updatePacket(quizId, packetId){
    var baseUrl = $("#base-url").attr("href");
    
    // Make the spining when waiting
    // Disable submit button

    // Post to api
    $.post(
            baseUrl + "admin/testapi",
            {
                id: quizId,
                packet_id: packetId
            },
            function(data) {
                console.log("updatePacket");
                if (data.code === 1) { // Successful
                    
                    // Update the first form
                    $('#packet').val(data.info.packet_id);
                } else { // Fail

                }
            },
            "json"
            );
}

function updatePoint(quizId, point){
    var baseUrl = $("#base-url").attr("href");
    
    // Make the spining when waiting
    // Disable submit button

    // Post to api
    $.post(
            baseUrl + "admin/testapi",
            {
                id: quizId,
                point: point
            },
            function(data) {
                console.log(data);
                if (data.code === 1) { // Successful
                    
                    // Update the first form
                    $('#point').val(data.info.point);
                } else { // Fail

                }
            },
            "json"
            );
}

function approveQuiz(quizId, state){
    var baseUrl = $("#base-url").attr("href");
    
    // Make the spining when waiting
    // Disable submit button

    // Post to api
    $.post(
            baseUrl + "admin/testapi",
            {
                id: quizId,
                state: state
            },
            function(data) {
                console.log(data);
                if (data.code === 1) { // Successful
                    if (data.info.state ===1){
                        $('#approve').attr('disabled', 'true');
                        $('#deny').removeAttr("disabled");
                    } else {
                        $('#deny').attr('disabled', 'true');
                        $('#approve').removeAttr("disabled");
                    }
                } else { // Fail

                }
            },
            "json"
            );
}

function callDelete(quizId){
    bootbox.confirm(
            "Are you sure you want to delete this question. The action cannot be undone!",
            function(result){
                if (result){
                    deleteQuiz(quizId);
                }
            }
        );
}

function deleteQuiz(quizId){
    var baseUrl = $("#base-url").attr("href");
    console.log("Deleting");
    // Make the spining when waiting
    // Disable submit button

    // Post to api
    $.post(
            baseUrl + "admin/testapi",
            {
                id: quizId,
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