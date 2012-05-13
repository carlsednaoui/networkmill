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

  $('.sign-in').click ->
    false


  # ---------------------------------------
  # Sign up modal logic
  # ---------------------------------------

  $('.sign-up').click ->
    lpos = (960-277)/2
    tpos = ($(window).height()-169)/2
    $('#sign-up').css({ left: lpos, top: tpos }).fadeIn 400
    $('.underlay').fadeIn 400
    document.onkeydown = (e) -> $('.underlay').click() if e.keyCode == 27
    false

  $('.underlay').click ->
    $('#sign-up').fadeOut 400
    $(this).fadeOut 400

  saved_pass = ""

  $('.password-field').keyup (e) ->
    saved_pass = $(this).val()

  $('.show-pass').click ->
    if $(this).is(':checked')
      console.log 'turning on'
      $('.pass-visible').val(saved_pass)
      $('#sign-up .password-field').hide()
      $('.pass-visible').css display: 'block'
    else
      console.log 'turning off'
      saved_pass = $('.pass-visible').val()
      $('#sign-up .password-field').val(saved_pass)
      $('.pass-visible').hide()
      $('#sign-up .password-field').show()

  $('#sign-up .form-submit').click ->
    if $('.show-pass').not(':checked')
      alert 'submitting with visible password!'
      saved_pass = $('.pass-visible').val()
      $('#sign-up .password-field').val(saved_pass)
      $('#sign-up .new_user').submit()
      false 