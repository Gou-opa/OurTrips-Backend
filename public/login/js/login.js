const inputs = document.querySelectorAll('.input');

function focusFunction () {
    let parent = this.parentNode.parentNode;
    parent.classList.add('focus');
}

function blurFunction () {
    let parent = this.parentNode.parentNode;
    if (this.value == "") {
        parent.classList.remove('focus');
    }
}

inputs.forEach(input => {
    input.addEventListener('focus', focusFunction);
    input.addEventListener('blur', blurFunction);
});

$('#register_form').submit(function (e) {
    e.preventDefault();
    var url = $(this).attr('action');
    console.log($("input[name='gender']:checked").val());
    $.ajax({
        url: url,
        type: 'post',
        data: {
            username: $("input[name='username']").val(),
            password: $("input[name='password']").val(),
            name: $("input[name='name']").val(),
            gender: $("input[name='gender']:checked").val(),
            birthday: $("input[name='birthday']").val(),
            address: $("input[name='address']").val(),
            email: $("input[name='email']").val(),
            tel: $("input[name='tel']").val(),
            nationality: $("input[name='nationality']").val(),
        },
        dataType: "json",

        success: function() {
            window.location.assign("/");
        },
        error: function (xhr, textStatus, error) {
            console.log(xhr.status);
            console.log(error);
        }
    });
});