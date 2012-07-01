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
      $('#sign-in-form').fadeOut 400
    , 500

  $('.sign-in').hover ->
    clearTimeout signin_timer
    $(this).addClass 'active'
    $('#sign-in-form').fadeIn 400
  , ->
    signin_menu_out()

  $('#sign-in-form').hover ->
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
      return false
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
      # $('.preview').fadeOut(400)
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
  $('.contact_avatar').on 'change', ->
    console.log 'hello!'
    input = $(this)[0]
    if input.files && input.files[0]
      reader = new FileReader()
      reader.onload = (e) =>
        $(this).prev().show().attr('src', e.target.result)
      reader.readAsDataURL(input.files[0])

  # validate fields before submit, since this is evaluted with html
  # this needs to happen for update action as well!
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
  # Edit Contact
  # ---------------------------------------

  $('.edit-contact').on 'click', ->
    li_element = $(this).parent().parent()
    $('.editing-contact').slideUp()
    # $('.preview').fadeOut()
    $('.add-contact').slideUp()
    $('.new-contact-button').css opacity: 1
    unless li_element.next().is(':visible')
      li_element.next().slideDown()
      li_element.next().find('.preview').fadeIn()
    false

  # ---------------------------------------
  # Login Validation
  # ---------------------------------------

  $('#new_user').bind "ajax:error", (e, data, status, xhr) ->
    $('#user_email').before("<div id='sign-in-error'>#{data.responseText}</div>")
  
  $('#new_user .form-submit').click ->
    $('#sign-in-error').remove()

  # ---------------------------------------
  # Homepage reset password
  # ---------------------------------------

  $('.forgot-pass').click ->
    $('#new_user').toggle()
    $('#forgot-password-form').toggle()
    false

  # ---------------------------------------
  # Load Spinner
  # ---------------------------------------

  opts =
    lines: 13 
    length: 7
    width: 4
    radius: 10
    rotate: 0
    color: '#000'
    speed: 1
    trail: 60
    shadow: false
    hwaccel: false
    className: 'spinner'
    zIndex: 2e9
    top: 'auto'
    left: 'auto'

  $('#submit').click ->
    $(this).spin(opts)

  # ---------------------------------------
  # Add Social Networks
  # ---------------------------------------

  if $('#settings').length
    count = $('.social-network-count').data('count')

    $('.add-field').on 'click', ->
      $(this).before $("<input name='user[social_networks_attributes][#{count}][name]' type='hidden'></>")
      $(this).before $("<input name='user[social_networks_attributes][#{count}][link]'></>")
      count += 1


























    


