/*
 * Quest Table
 */

var questTable;

$(document).ready(function(){
    $('#quest').html( '<table cellpadding="0" cellspacing="0" border="0" class="display table table-striped table-bordered" id="quest-table"></table>' );
    questTable = $('#quest-table').dataTable({
        "aoColumns":[
            { "sTitle": "Quest'name" },
            { "sTitle": "Packet" },
            { "sTitle": "Point of Advance" },
            { "sTitle": "Action", "sClass": "center" }
        ],
        "sPaginationType": "bootstrap",
        "bSort": false
    });
    loadQuestTable();
});

function loadQuestTable(){
    var baseUrl = $("#base-url").attr("href");
    
    // Make the spining when waiting

    // Post to api
    $.post(
            baseUrl + "virtualquest/getVirtualQuestList",
            {
                pageSize: 0,
                pageNumber: 0
            },
            function(data) {
                console.log(data);
                if (data.code == 1) { // Successful
                    var quesetArray = data.info.quest;
                    var tableData = new Array();
                    var quest;
                    var action;
                    for (var i=0; i<quesetArray.length; i++){
                        quest = quesetArray[i];
                        
                        action = '<a href="'+baseUrl+'admin/edit_quest/'+quest.Id+'">View</a>  <a onclick="callDeleteQuest('+quest.Id+')" href="javacript:void(0);">Delete</a>';
                        tableData.push([
                            quest.QuestName,
                            quest.PacketName,
                            quest.UnlockPoint,
                            action
                        ]);
                    }
                    questTable.fnClearTable();
                    questTable.fnAddData(tableData);
                } else { // Fail

                }
            },
            "json"
            );
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
                if (data.code == 1) { // Successful
                    loadQuestTable();
                } else { // Fail
                    bootbox.alert("Some error happened that we cannot delete the quest. Please try again later.", 
                        function(){
                            
                        });
                }
            },
            "json"
            );
}


/*
 * Quiz Table
 */

var quizTable;

$(document).ready(function(){
    $('#quiz').html( '<table cellpadding="0" cellspacing="0" border="0" class="display table table-striped table-bordered" id="quiz-table"></table>' );
    quizTable = $('#quiz-table').dataTable({
        "aoColumns":[
            { "sTitle": "Author" },
            { "sTitle": "Quiz Category", "sClass": "center" },
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
            baseUrl + "quiz/getQuizList",
            {
                pageSize: 0,
                pageNumber: 0
            },
            function(data) {
                console.log(data);
                if (data.code == 1) { // Successful
                    var quizArray = data.info.quiz;
                    var tableData = new Array();
                    var quiz;
                    var isApproved;
                    var action;
                    for (var i=0; i<quizArray.length; i++){
                        quiz = quizArray[i];
                        if (quiz.IsApproved == 1){
                            isApproved = "Yes";
                        }else {
                            isApproved = 'No';
                        }
                        action = '<a href="'+baseUrl+'admin/edit_quiz/'+quiz.Id+'">View</a>  <a onclick="callDelete('+quiz.Id+')" href="javacript:void(0);">Delete</a>';
                        tableData.push([
                            quiz.PartnerName,
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
            baseUrl + "quiz/updateIsApproved",
            {
                id: quizId,
                is_approved: state
            },
            function(data) {
                console.log(data);
                if (data.code === 1) { // Successful
                    // TODO
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
            baseUrl + "quiz/deleteQuiz",
            {
                id: quizId,
            },
            function(data) {
                console.log(data);
                if (data.code == 1) { // Successful
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


/*
 * Table of Activity
 */

var activityTable;

$(document).ready(function(){
    $('#activity').html( '<table cellpadding="0" cellspacing="0" border="0" class="display table table-striped table-bordered" id="activity-table"></table>' );
    activityTable = $('#activity-table').dataTable({
        "aoColumns":[
            { "sTitle": "Title of Activity" },
            { "sTitle": "Author" },
            { "sTitle": "Point Value", "sClass": "center"},
            { "sTitle": "Approve?", "sClass": "center" },
            { "sTitle": "Action", "sClass": "center" }
        ],
        "sPaginationType": "bootstrap",
        "bSort": false
    });
    loadActivityTable();
    
});

function loadActivityTable(){
    var baseUrl = $("#base-url").attr("href");
    
    // Make the spining when waiting
    // Post to api
    $.post(
            baseUrl + "activity/getActivityList",
            {
                pageSize: 0,
                pageNumber: 0
            },
            function(data) {
                console.log(data);
                if (data.code === 1) { // Successful
                    var actArray = data.info.activity;
                    var tableData = new Array();
                    var act;
                    var isApproved;
                    var action;
                    for (var i=0; i<actArray.length; i++){
                        act = actArray[i];
                        if (act.IsApproved == 1){
                            isApproved = "Yes";
                        }else {
                            isApproved = 'No';
                        }
                        action = '<a href="'+baseUrl+'admin/edit_activity/'+act.Id+'">View</a>  <a onclick="callDeleteAct('+act.Id+')" href="javacript:void(0);">Delete</a>';
                        tableData.push([
                            act.Title,
                            act.PartnerName,
                            act.BonusPoint+'pts',
                            isApproved,
                            action
                        ]);
                    }
                    activityTable.fnClearTable();
                    activityTable.fnAddData(tableData);
                } else { // Fail

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
            baseUrl + "activity/updateIsApproved",
            {
                id: activityId,
                is_approved: state
            },
            function(data) {
                console.log(data);
                if (data.code === 1) { // Successful
                    // TODO
                } else { // Fail

                }
            },
            "json"
            );
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
            baseUrl + "activity/deleteActivity",
            {
                id: activityId,
            },
            function(data) {
                console.log(data);
                if (data.code === 1) { // Successful
                    loadActivityTable();
                } else { // Fail
                    bootbox.alert("Some error happened that we cannot delete the quest. Please try again later.", 
                        function(){
                            
                        });
                }
            },
            "json"
            );
}


/*
 * Table of Donation
 */

var donationTable;

$(document).ready(function(){
    $('#donation').html( '<table cellpadding="0" cellspacing="0" border="0" class="display table table-striped table-bordered" id="donation-table"></table>' );
    donationTable = $('#donation-table').dataTable({
        "aoColumns":[
            { "sTitle": "Title of Donation" },
            { "sTitle": "Author" },
            { "sTitle": "Cost"},
            { "sTitle": "Approve?", "sClass": "center" },
            { "sTitle": "Action", "sClass": "center" }
        ],
        "sPaginationType": "bootstrap",
        "bSort": false
    });
    loadDonationTable();
    
});

function loadDonationTable(){
    var baseUrl = $("#base-url").attr("href");
    
    // Make the spining when waiting
    // Post to api
    $.post(
            baseUrl + "donation/getDonationList",
            {
                pageSize: 0,
                pageNumber: 0
            },
            function(data) {
                console.log(data);
                if (data.code === 1) { // Successful
                    var donationArray = data.info.donation;
                    var tableData = new Array();
                    var donation;
                    var isApproved;
                    var action;
                    for (var i=0; i<donationArray.length; i++){
                        donation = donationArray[i];
                        if (donation.IsApproved == 1){
                            isApproved = "Yes";
                        }else {
                            isApproved = 'No';
                        }
                        action = '<a href="'+baseUrl+'admin/edit_donation/'+donation.Id+'">View</a>  <a onclick="callDeleteDonation('+donation.Id+')" href="javacript:void(0);">Delete</a>';
                        tableData.push([
                            donation.Title,
                            donation.PartnerName,
                            '-'+donation.RequiredPoint+'pts',
                            isApproved,
                            action
                        ]);
                    }
                    donationTable.fnClearTable();
                    donationTable.fnAddData(tableData);
                } else { // Fail

                }
            },
            "json"
            );
}

function approveDonation(activityId, state){
    var baseUrl = $("#base-url").attr("href");
    
    // Make the spining when waiting
    // Disable submit button

    // Post to api
    $.post(
            baseUrl + "donation/updateIsApproved",
            {
                id: activityId,
                is_approved: state
            },
            function(data) {
                console.log(data);
                if (data.code === 1) { // Successful
                    // TODO
                } else { // Fail

                }
            },
            "json"
            );
}

function callDeleteDonation(donationId){
    bootbox.confirm(
            "Are you sure you want to delete this Activity. The action cannot be undone!",
            function(result){
                if (result){
                    deleteDonation(donationId);
                }
            }
        );
}

function deleteDonation(donationId){
    var baseUrl = $("#base-url").attr("href");
    console.log("Deleting");
    // Make the spining when waiting
    // Disable submit button

    // Post to api
    $.post(
            baseUrl + "donation/deleteDonation",
            {
                id: donationId,
            },
            function(data) {
                console.log(data);
                if (data.code === 1) { // Successful
                    loadDonationTable();
                } else { // Fail
                    bootbox.alert("Some error happened that we cannot delete the quest. Please try again later.", 
                        function(){
                            
                        });
                }
            },
            "json"
            );
}