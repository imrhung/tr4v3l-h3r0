var quizTable;

$(document).ready(function(){
    $('#quiz').html( '<table cellpadding="0" cellspacing="0" border="0" class="display table table-striped table-bordered" id="quiz-table"></table>' );
    quizTable = $('#quiz-table').dataTable({
        "aoColumns":[
            { "sTitle": "Author" },
            { "sTitle": "Quest Category", "sClass": "center" },
            { "sTitle": "Approve?", "sClass": "center" },
            { "sTitle": "Action", "sClass": "center" }
        ],
        "sPaginationType": "bootstrap",
        "bSort": false
    });
    loadQuizTable();
});

function loadQuizTable(){
    var baseUrl = $("#base-url").attr("href");
    
    // Make the spining when waiting

    // Post to api
    $.post(
            baseUrl + "admin/testapi",
            {
                pageSize: 0,
                pageNumber: 0
            },
            function(data) {
                console.log(data);
                if (data.code === 1) { // Successful
                    var quizArray = data.info.quiz;
                    var tableData = new Array();
                    var quiz;
                    var isApproved;
                    var action;
                    for (var i=0; i<quizArray.length; i++){
                        quiz = quizArray[i];
                        if (quiz.IsApproved === 1){
                            isApproved = "Yes";
                        }else {
                            isApproved = '<button id="approve" name="approve" class="btn btn-success" onclick="approveQuiz('+quiz.Id+', 1);">Yes</button> <button id="deny" name="deny" class="btn btn-danger">No</button>';
                        }
                        action = '<a href="'+baseUrl+'admin/edit_quiz/'+quiz.Id+'">View</a>  <a onclick="callDelete('+quiz.Id+')" href="javacript:void(0);">Delete</a>';
                        tableData.push([
                            quiz.Name,
                            quiz.CategoryName,
                            isApproved,
                            action
                        ]);
                    }
                    quizTable.fnClearTable();
                    quizTable.fnAddData(tableData);
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
                        loadQuizTable();
                    } else {
                        
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
                    loadQuizTable();
                } else { // Fail
                    bootbox.alert("Some error happened that we cannot delete the quest. Please try again later.", 
                        function(){
                            
                        });
                }
            },
            "json"
            );
}