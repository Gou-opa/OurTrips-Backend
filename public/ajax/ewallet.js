$(document).ready(function(){
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
});