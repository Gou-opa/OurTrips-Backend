$("#login_form").validate({
    rules: {
        username: {
            required: true
        },
        password: {
            required: true
        }
    },
    messages: {
        username: {
            required: "* Bạn chưa điền Email"
        },
        password: {
            required: "* Bạn chưa điền password"
        }
    },
    errorPlacement: function (label, elem) {
        var name = elem.attr('name');
        var spanError = '#' + name;
        $(spanError).append(label.addClass('text-error'));
    },
});

$("#register_form").validate({
    rules: {
        username: {
            required: true,
            maxlength: 18,
            minlength: 6,
        },
        name : {
            required: true,
        },
        gender: {
            required: true,
        },
        birthday: {
            required: true,
        },
        address: {
            required: true,
        },
        email: {
            required: true,
            email: true
        },
        tel: {
            required: true,
            number: true
        },
        nationality: {
            required: true,
        },
        password: {
            required: true,
            minlength: 6
        },
        password_confirmation: {
            required: true,

        },

    },
    messages: {
        username: {
            required: "* Bạn chưa điền Username",
            maxlength: "* Nhập tối đa 18 kí tự",
            minlength: "* Nhập tối thiểu 6 kí tự"
        },
        name: {
            required: "* Bạn chưa điền họ tên"
        },
        gender: {
            required: "* Bạn chưa điện giới tính",
        },
        birthday: {
            required: "* Bạn chưa điền ngày sinh",
        },
        address: {
            required: "* Bạn chưa điền địa chỉ",
        },
        email: {
            required: "*Bạn chưa điền email",
            email: "* Email chưa đúng định dạng",
        },
        tel: {
            required: "* Bạn chưa nhập số điện thoại",
            number: "* Bạn phải nhập đúng định dạng"
        },
        nationality: {
            required: "* Bạn chưa nhập quốc tịch",
        },
        password: {
            required: "* Bạn chưa điền password",
            minlength: "Nhập tối thiểu 6 kí tự"
        },
        password_confirmation: {
            required: "* Bạn chưa nhập lại mật khẩu",
            equalTo: "* Mật khẩu không trùng khớp",
        }
    },
    errorPlacement: function (label, elem) {
        var name = elem.attr('name');
        var spanError = '#' + name;
        $(spanError).append(label.addClass('text-error'));
    },
});

$('#forgotpassowrd_form').validate({
    rules: {
        email_registration: {
            required: true,
            email: true
        }
    },
    messages: {
      email_registration: {
          required: "* Bạn cần phải nhập email đã đăng ký",
          email: "* Email bạn nhập sai định dạng",
      }
    },
    errorPlacement: function (label, elem) {
        var name = elem.attr('name');
        var spanError = '#' + name;
        $(spanError).append(label.addClass('text-error'));
    },
});

