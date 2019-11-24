function form_submit(url, formid, onSuccess) {
   $('#'+ formid).submit(function(e){
      e.preventDefault();
      var val = $(this).serialize();
      $.post(url, val, onSuccess, "json");
      localStorage.setItem('username', JSON.stringify($('#username').val()));
   });
}

$().ready(function(){
   $('span#name_username').html(JSON.parse(localStorage.getItem('username')));
});

