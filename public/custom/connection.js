function form_submit(url, formid, onSuccess) {
   $('#'+ formid).submit(function(){
      $.post(
          $(this).attr('action'),
          $(this).serialize(),
          onSuccess,
          "json"
      );
   });
}

