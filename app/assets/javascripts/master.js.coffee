$ ->

  # ---------------------------------------
  # Flash Notices / Helpers
  # ---------------------------------------

  $('.notice').delay(1000).fadeOut()

  valid_email = (val) ->
    val.match /[\w\.%\+\-]+@[\w\-]+\.\w{2,3}/

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

  # when the user hits sign up, we validate the email and password,
  # then make sure that the password is copied correctly between the
  # visible / hidden pass field before submitting
  $('#sign-up .form-submit').click (e) ->

    $('.form-error').remove()

    if !valid_email $('#sign-up .email-field').val()
      $('#sign-up .email-field').before "<div class='form-error'>please enter a valid email</div>"
    else if saved_pass.length < 6
      $('#sign-up .email-field').before "<div class='form-error'>password must be more than 6 characters</div>"
    else
      if $('#show-pass').is(':checked')
        saved_pass = $('.pass-visible').val()
        $('#sign-up .password-field').val(saved_pass)

    $.ajax
      url: "/check_email/#{$('#sign-up .email-field').val()}"
      success: (data) ->
        if data == "true"
          $('#sign-up .email-field').before "<div class='form-error'>email has already been taken</div>"
        else
          $('#sign-up .new_user').submit()

    return false

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
  # Add Contact Section
  # ---------------------------------------
  
  # slide down the box
  add_contact_down = false
  $('.new-contact-button').on 'click', ->
    $('.editing-contact').slideUp()
    if add_contact_down
      $('.add-contact').slideUp()
      $(this).css opacity: 1
      add_contact_down = false
      $('.preview').fadeOut(400)
    else
      $('.add-contact').slideDown()
      $(this).css opacity: .6
      add_contact_down = true
      $('.preview').fadeIn(400) if $('.preview').attr('src')
    false

  # slide down the add notes box
  $('.add-notes span').on 'click', ->
    $('.add-notes .field').slideToggle()

  # preview uploaded images
  $('#contact_avatar').on 'change', ->
    input = document.getElementById('contact_avatar')
    if input.files && input.files[0]
      reader = new FileReader()
      reader.onload = (e) ->
        $('.add-contact').find($('.preview')).show().attr('src', e.target.result)
      reader.readAsDataURL(input.files[0])

  # validate fields before submit, since this is evaluted with html
  $('#new_contact input[type=submit]').on 'click', (e) ->
    popup = $("<div class='popup'></div>")

    unless $('#contact_name').val().match /\S+/
      e.preventDefault()
      pos = $('#contact_name').position()
      $('#container').prepend(popup)
      popup.css({ top: pos.top - 65, left: pos.left }).text("make sure your contact has a name!").fadeIn().delay(1500).fadeOut 400, -> $(this).remove()

    unless valid_email $('#contact_email').val()
      e.preventDefault()
      pos = $('#contact_email').position()
      $('#container').prepend(popup)
      popup.css({ top: pos.top - 65, left: pos.left }).text("please enter a valid email address").fadeIn().delay(1500).fadeOut 400, -> $(this).remove()
  
  # ---------------------------------------
  # Delete Contact
  # ---------------------------------------

  # $('.delete-contact').on 'click', ->
  #   $('.popup2').fadeOut 400, -> $(this).remove()
  #   pos = $(this).position()
  #   popup = $("<div class='popup2'></div>")
  #   popup.appendTo($('#container')).css({ top: pos.top - 65, left: pos.left - 57 }).text("for real?").fadeIn()
  #   false

  # ---------------------------------------
  # Edit Contact
  # ---------------------------------------

  $('.edit-contact').on 'click', ->
    li_element = $(this).parent().parent()
    $('.editing-contact').slideUp()
    $('.preview').fadeOut()
    $('.add-contact').slideUp()
    unless li_element.next().is(':visible')
      li_element.next().slideDown()
      li_element.next().find('.preview').fadeIn()
    false

  # ---------------------------------------
  # Login Validation
  # ---------------------------------------

  $('#new_user').bind "ajax:error", (e, data, status, xhr) ->
    $('#user_email').before("<div id='sign_in_error'>#{data.responseText}</div>")
  
  $('#new_user .form-submit').click ->
    $('#sign_in_error').remove()




