$ ->

  # ---------------------------------------
  # Sign in menu logic
  # ---------------------------------------
  
  signin_timer = null

  signin_menu_out = ->
    signin_timer = setTimeout =>
      $('.sign-in').removeClass 'active'
      $('#new_user').fadeOut 400
    , 500

  $('.sign-in').hover ->
    $(this).addClass 'active'
    $('#new_user').fadeIn 400
  , ->
    signin_menu_out()

  $('#new_user').hover ->
    clearTimeout signin_timer
  , ->
    signin_menu_out()