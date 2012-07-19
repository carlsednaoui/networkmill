// Wondering what this is, how it's so fast, or how to get in touch with us?
// Fear no more, just email hi@networkmill.com and we'll chat.

$(function(){

  $('h1').css({ top: (window.innerHeight - 41) / 2, left: (window.innerWidth - 127) / 2 }).fadeIn()
  $('form').css({ top: (window.innerHeight - 55) / 2, left: (window.innerWidth - 265) / 2 }).show()

  $(window).resize(function(){ 
    $('h1').css({ top: (window.innerHeight - 91) / 2, left: (window.innerWidth - 127) / 2 });
    if ($('form').hasClass('down')) {
      $('form').css({ top: (window.innerHeight + 41) / 2, left: (window.innerWidth - 265) / 2 })
    } else {
      $('form').css({ top: (window.innerHeight - 55) / 2, left: (window.innerWidth - 265) / 2 })
    }
  });

  $('h1').on('click', function(){
    $(this).focus().css({ top: (window.innerHeight - 101) / 2 });
    $('form').addClass('down').css({ top: (window.innerHeight + 40) / 2, opacity: 1 });
    $('input').focus();
  });

  $('form').on('submit', function(){
    $.ajax({
      url: '/add',
      type: 'post',
      data: $(this).serialize(),
      complete: function(data){
        if (data.responseText == "success!") {
          $('.thanks').show().delay(1200).fadeOut()
          $('input').val('')
        }
      }
    })
    return false;
  })

});