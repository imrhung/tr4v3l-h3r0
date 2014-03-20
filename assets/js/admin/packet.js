$(function(){
    drawPacketTable();
    drawCategoryTable();
});

function drawPacketTable(){
    var baseUrl = $("#base-url").attr("href");
    
    // Post to api
    $.post(
            baseUrl + "admin/testPackets",
            {
                pageSize: 0,
                pageNumber: 0
            },
            function(data) {
                console.log(data);
                if (data.code == 1) { // Successful
                    var packets = data.info.packet;
                    var packetTable = $('#packet-table');
                    for (var i=0; i<packets.length; i++){
                        var row = $('<tr></tr>');
                        var name = $('<td></td>').text(packets[i].Title);
                        var background = $('<td></td>').text("default.png");
                        row.append(name).append(background);
                        packetTable.append(row);
                    }
                  
                } else { // Fail
                    
                }
            },
            "json"
        );
}

function drawCategoryTable(){
    var baseUrl = $("#base-url").attr("href");
    
    // Post to api
    $.post(
            baseUrl + "admin/getCategory",
            {
                pageSize: 0,
                pageNumber: 0
            },
            function(data) {
                console.log(data);
                if (data.code == 1) { // Successful
                    var categorys = data.info.category;
                    var cateTable = $('#category-table');
                    for (var i=0; i<categorys.length; i++){
                        var row = $('<tr></tr>');
                        var name = $('<td></td>').text(categorys[i].CategoryName);
                        var background = $('<td></td>').text(categorys[i].Id);
                        row.append(name).append(background);
                        cateTable.append(row);
                    }
                  
                } else { // Fail
                    
                }
            },
            "json"
        );
}

function createPacket(){
    var baseUrl = $("#base-url").attr("href");
    var title = $('#packet').val();
    // Post to api
    $.post(
            baseUrl + "admin/getCategory",
            {
                title: title,
                image_url:'http://google.com/image',
                partner_id:1
            },
            function(data) {
                console.log(data);
                if (data.code == 1) { // Successful
                    
                    // Draw that new row in table
                    var packetTable = $('#packet-table');
                    var row = $('<tr></tr>');
                    var name = $('<td></td>').text(title);
                    var background = $('<td></td>').text("default.png");
                    row.append(name).append(background);
                    packetTable.append(row);
                    
                    // Clear the input
                    $('#packet').val("");
                } else { // Fail
                    
                }
            },
            "json"
        );
}

function createCategory(){
    var baseUrl = $("#base-url").attr("href");
    var category = $('#category').val();
    // Post to api
    $.post(
            baseUrl + "admin/getCategory",
            {
                category_name: category
            },
            function(data) {
                console.log(data);
                if (data.code == 1) { // Successful
                    
                    // Draw that new row in table
                    var categoryTable = $('#category-table');
                    var row = $('<tr></tr>');
                    var name = $('<td></td>').text(category);
                    var background = $('<td></td>').text('');
                    row.append(name).append(background);
                    categoryTable.append(row);
                    
                    // Clear the input
                    $('#category').val("");
                } else { // Fail
                    
                }
            },
            "json"
        );
}

