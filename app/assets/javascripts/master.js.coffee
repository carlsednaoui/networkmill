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
    clearTimeout signin_timer
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

  $('#show-pass').click ->
    if $(this).is(':checked')
      $('.pass-visible').val(saved_pass)
      $('#sign-up .password-field').hide()
      $('.pass-visible').css display: 'block'
    else
      saved_pass = $('.pass-visible').val()
      $('#sign-up .password-field').val(saved_pass)
      $('.pass-visible').hide()
      $('#sign-up .password-field').show()

  $('#sign-up .form-submit').click (e) ->
    if $('#show-pass').is(':checked')
      saved_pass = $('.pass-visible').val()
      $('#sign-up .password-field').val(saved_pass)
      $('#sign-up .new_user').submit()
      false

  # ---------------------------------------
  # Account Dropdown (needs major revision)
  # ---------------------------------------

  account_timer = null

  account_menu_out = ->
    account_timer = setTimeout =>
      $('.account').removeClass 'active'
      $('.dropdown').fadeOut 400
    , 500

  $('.account').hover ->
    clearTimeout account_timer
    $(this).addClass 'active'
    $('.dropdown').fadeIn 400
  , ->
    account_menu_out()

  $('.dropdown').hover ->
    clearTimeout account_timer
  , ->
    account_menu_out()

  # ---------------------------------------
  # Add Contact Button
  # ---------------------------------------
  
  add_contact_down = false
  $('.new-contact-button').on 'click', ->
    if add_contact_down
      $('.add-contact').slideUp()
      $(this).css opacity: 1
      add_contact_down = false
    else
      $('.add-contact').slideDown()
      $(this).css opacity: .7
      add_contact_down = true
    false

  $('.add-contact input[type=submit]').on 'click', ->
    unless $('#contact_email').val().match /[\w\.\+\-\%]+@[\w\-\_]+\.\w{2,}/i
      $('#contact_email').addClass 'error'
  




















