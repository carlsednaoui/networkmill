//= require jquery
//= require jquery_ujs

# notes:
# we can probably remove ujs here. eventually we will want to convert this to zepto
# any on click needs to be converted to a touch event for speed (saves about 1ms)

$ ->

  # flip the page when the cog is clicked
  $('.cog').on 'click', ->
    $('#card').addClass 'flipped'
    false

  $('#start-networking').on 'click', ->
    $('#card').removeClass 'flipped'
    setTimeout ->
      $('#preference form').submit()
      $('.loading').show().find('.spinner').css position: 'absolute'
    , 1300
    false

  # slide down the note section
  $('#write-note').on 'focus', ->
    $(@).css height: 100, color: "rgba(255,255,255,1)"
  .on 'blur', ->
    $(@).css height: 18, color: "rgba(255,255,255,.4)"
  .on 'keydown', ->
    $(@).css textAlign: 'left'

  $('#preference textarea').on 'focus', ->
    $(@).css height: 155
  .on 'blur', ->
    $(@).css height: 125

  # Login Validation

  $('#new_user').bind "ajax:error", (e, data, status, xhr) ->
    $('#user_email').before("<div id='sign-in-error'>#{data.responseText}</div>")
  
  $('#new_user .sign-in-submit').click ->
    $('#sign-in-error').remove()

  # fade out flash messages
  $('.flash').delay(1500).fadeOut 500

  # Get all information about the device's state

  if window.navigator.standalone
    console.log 'user is running it as a mobile web app'
  else
    if navigator.userAgent.match /like Mac OS X/i
      setTimeout (-> window.scrollTo(0,1)), 1000
      $('#sign-in, #card').hide()
      $('.splash').show()
    else
      console.log 'user is visiting from android or other mobile OS'