$(document).ready(function(){
    $('#tinh').on('change',() => {
        var id = $('#tinh').val();
        $("#value-city").val($('#tinh option:selected').html());
        $.get('/driver/tinh/'+id, function(data){
            $('#huyen').contents().remove();
            $('#huyen').append("<option value=''>--Chọn--</option>");
            for(var j = 0; j < data.length; j++)
            {
                $('#huyen').append("<option value='"+data[j].id+"'>"+data[j].name+"</option>");
            }
        });
    });
    $('#huyen').on('change', () => {
        var district = $('#huyen option:selected').html();
        $('#value-district').val(district);
    });
});