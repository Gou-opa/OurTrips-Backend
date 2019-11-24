
// code to read selected table row cell data (values).
$(".btn-show1").on('click',function(){
    let currentRow = $(this).closest("tr");
    let colValue = currentRow.find("td:eq(1)").html();
    let url = '';
    //ajax
    $.ajax({
        url: url,
        type: "post",
        dataType: "json",
        data: {
            accountNumber: colValue,
        },
        success: function(response) {
            let table = $('#table-show1');
            table.find('#accountNumber').html(response.accountNumber);
            table.find('#bank').html(response.bank);
            table.find('#money').html(response.money);
        }
    });

});


function load_ewalet() {
    $.ajax({
        url: '/ewallet/fetch',
        type: 'post',
        dataType: 'json',
        data: {
            username: JSON.parse(localStorage.getItem('username')),
            token: JSON.parse(localStorage.getItem('token')),
            max: '',
            filter: ['acountNumber'],
        },
        success: function(response) {
            var html = '';
            var array = response.requests;
            var count = 1;
            $.each(array, function(key, val){
                html += '<tr>';
                html += '<td width="5%" align="center">'+ count +'</td>';
                html += '<td width="25%">'+ val.user_id + '</td>';
                html += '<td width="25%">'+ val.accountNumber + '</td>';
                html += '<td width="25%">'+ val.vendor + '</td>';
                html += '<td width="20%" align="center">\n' +
                    '<div class="btn-group">\n' +
                    '<button type="button" class="btn btn-primary bg-color" data-toggle="modal" data-target="#modal-default2">\n' +
                    'Chi tiết\n' +
                    '</button>\n' +
                    '<button type="button" class="btn btn-primary bg-color">\n' +
                    'Xóa\n' +
                    '</button>\n' +
                    '</div>\n' +
                    '</td>';
                html += '</tr>';
                $('#show_ewallet').find('tbody').html(html);
                count++;
            });

        }
    });

}




$('#createWallet').on('click', function(){
    $('#message').html('Đang tạo...');
    $.ajax({
        url: "/ewallet/register",
        type: 'post',
        dataType: 'json',
        data: {
            username: JSON.parse(localStorage.getItem('username')),
            token: JSON.parse(localStorage.getItem('token')),
        },
        success: function(response) {
            $('#message').hide()
            $('#message1').html(response.message+'!');
            setTimeout(function(){
                $('#message1').hide();
            }, 3000);

        }
    });
});

$("#ewallet_link_form").on('submit', function(e){
    e.preventDefault();
    var data = {
        username: JSON.parse(localStorage.getItem('username')),
        token: JSON.parse(localStorage.getItem('token')),
        accountNumber: $('input[name="accountNumber"]').val(),
        vendor: $('input[name="vendor"]').val(),
    };
    $.ajax({
        url: $(this).attr('action'),
        type: $(this).attr('method'),
        dataType: 'JSON',
        data: data,
        success: function (response) {
            $('#message2').html(response.message+'!');
            setTimeout(function(){
                $('#message2').hide();
            }, 3000);
        }
    });
});



