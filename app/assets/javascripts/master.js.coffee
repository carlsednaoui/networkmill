$ ->

  # ---------------------------------------
  # Helpers
  # ---------------------------------------

  valid_email = (val) ->
    val.match /[\w\.%\+\-]+@[\w\-]+\.\w{2,3}/

  onpage = (name, cb) ->
    cb() if $(name).length

  # ----------------------------------------
  # Global scripts
  # ----------------------------------------

  # deal with flash notices

  $('.notice').delay(1000).fadeOut()

  # account menu (needs a lot of work)

  account_timer = null

  account_menu_out = ->
    account_timer = setTimeout =>
      $('.account').removeClass 'active'
      $('.dropdown').fadeOut 400
    , 500

  $('.account').hover ->
    clearTimeout account_timer
    $(@).addClass 'active'
    $('.dropdown').fadeIn 400
  , ->
    account_menu_out()

  $('.dropdown').hover ->
    clearTimeout account_timer
  , ->
    account_menu_out()

  # Load Spinner

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
    $(@).spin(opts)

  # Twilio text validation
  $('#text-app .form-submit').on 'click', ->
    $('.form-error').remove()

    if $('.telephone-field').val().length < 10
      $('#text-app .telephone-field').before "<div class='form-error'>woops, this doesn't seem to be a valid number</div>"
      false

  # ---------------------------------------
  # Script for the homepage
  # ---------------------------------------

  onpage '.root', ->

    # Sign in menu logic

    signin_timer = null

    signin_menu_out = ->
      signin_timer = setTimeout =>
        $('.sign-in').removeClass 'active'
        $('#sign-in-form').fadeOut 400
      , 500

    $('.sign-in').hover ->
      clearTimeout signin_timer
      $(@).addClass 'active'
      $('#sign-in-form').fadeIn 400
    , ->
      signin_menu_out()

    $('#sign-in-form').hover ->
      clearTimeout signin_timer
    , ->
      signin_menu_out()

    $('.sign-in').on 'click', ->
      false


    # Sign up modal logic

    $('.sign-up').on 'click', ->
      lpos = (960-277)/2
      tpos = ($(window).height()-169)/2
      $('#sign-up').css({ left: lpos, top: tpos }).fadeIn 400
      $('.underlay').fadeIn 400
      document.onkeydown = (e) -> $('.underlay').click() if e.keyCode == 27
      false

    $('.underlay').click ->
      $('#sign-up').fadeOut 400
      $(@).fadeOut 400

    saved_pass = ""

    $('.password-field').keyup (e) ->
      saved_pass = $(@).val()

    $('#show-pass').click ->
      if $(@).is(':checked')
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
        return false
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

    # Login Validation

    $('#new_user').bind "ajax:error", (e, data, status, xhr) ->
      $('#user_email').before("<div id='sign-in-error'>#{data.responseText}</div>")
    
    $('#new_user .form-submit').click ->
      $('#sign-in-error').remove()

    # Homepage reset password

    $('.forgot-pass').click ->
      $('#new_user').toggle()
      $('#forgot-password-form').toggle()
      false

    # Check Email Domain Name Logic (mailcheck.js)
    
    $('input[type=email]').on 'blur', ->
      $("#hint").hide()
      $(@).mailcheck
        suggested: (el, suggestion) ->
          $("#hint").show()
          $('#hint span').text(suggestion['full']).on 'click', ->
            $(el).val suggestion['full']
            $('#hint').hide()

  # ---------------------------------------
  # Scripts for the dashboard
  # ---------------------------------------

  onpage '.dashboard', ->

    # slide down add contact box

    add_contact_down = false
    $('.new-contact-button').on 'click', ->
      $('.editing-contact').slideUp()
      if add_contact_down
        $('.add-contact').slideUp()
        $(@).css opacity: 1
        add_contact_down = false
      else
        $('.add-contact').slideDown()
        $(@).css opacity: .6
        add_contact_down = true
        $('.preview').fadeIn(400) if $('.preview').attr('src')
      false

    # slide down the add notes box

    $('.add-notes span').on 'click', ->
      $('.add-notes .field').slideToggle()

    # preview uploaded images

    $('.contact_avatar').on 'change', ->
      console.log 'hello!'
      input = $(@)[0]
      if input.files && input.files[0]
        reader = new FileReader()
        reader.onload = (e) =>
          $(@).prev().show().attr('src', e.target.result)
        reader.readAsDataURL(input.files[0])

    # validate fields before submit, since this is evaluted with html
    # this needs to happen for update action as well!

    $('#new_contact input[type=submit]').on 'click', (e) ->
      popup = $("<div class='popup'></div>")

      unless $('#contact_name').val().match /\S+/
        e.preventDefault()
        pos = $('#contact_name').position()
        $('#container').prepend(popup)
        popup.css({ top: pos.top - 65, left: pos.left }).text("make sure your contact has a name!").fadeIn().delay(1500).fadeOut 400, -> $(@).remove()

      unless valid_email $('#contact_email').val()
        e.preventDefault()
        pos = $('#contact_email').position()
        $('#container').prepend(popup)
        popup.css({ top: pos.top - 65, left: pos.left }).text("please enter a valid email address").fadeIn().delay(1500).fadeOut 400, -> $(@).remove()

    # Edit Contact

    $('.edit-contact').on 'click', ->
      li_element = $(@).parent().parent()
      $('.editing-contact').slideUp()
      $('.add-contact').slideUp()
      $('.new-contact-button').css opacity: 1
      unless li_element.next().is(':visible')
        li_element.next().slideDown()
        li_element.next().find('.preview').fadeIn()
      false

  # ---------------------------------------
  # Scripts for preferences page
  # ---------------------------------------

  onpage '.preferences', ->

    # little utility to grab the width of a text element

    $.fn.textWidth = ->
      html_org = $(@).val()
      html_calc = "<span>#{html_org}</span>"
      $(@).after(html_calc)
      width = $(@).next().width()
      $(@).next().remove()
      width

    # add social networks logic

    count = $('#social-networks').data('count')

    $('.add-field').on 'click', ->
      $(@).before $("<input name='user[social_networks_attributes][#{count}][name]' type='hidden'></>")
      $(@).before $("<input name='user[social_networks_attributes][#{count}][link]'></>")
      count += 1

    $('.social').on 'click', 'a', ->
      if $(@).hasClass 'active'
        $(@).removeClass 'active'
        $(@).parent().find('.social-field').hide()
      else
        $('.social li .social-field').hide()
        $('.social li a').removeClass 'active'
        $(@).addClass 'active'
        $(@).parent().find('.social-field').show()

    $('#social-networks input').each (index, el) ->
      if $(el).attr('name').match /user\[social_networks_attributes\]\[\d+\]\[name\]/
        container = $(".#{$(el).val()}")
        container.append $(el).parent()

    # auto adjust the width of the user name input

    $('#user_name').css maxWidth: $('#user_name').textWidth() + 15
    $('#user_name').on 'keyup', ->
      $(@).css maxWidth: $(@).textWidth() + 15
      $('.contact-card .name').text $(@).val()

    $('#user_email').css maxWidth: $('#user_email').textWidth() + 3
    $('#user_email').on 'keyup', ->
      $(@).css maxWidth: $(@).textWidth() + 3
      $('.contact-card .email').text $(@).val()
