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
    setTimeout (-> $('#preference form').submit()), 1300
    false

  # slide down the note section
  $('#write-note').on 'click', ->
    $(@).css height: 100
  .on 'keydown', ->
    $(@).css textAlign: 'left'

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
    if window.navigator.onLine
      console.log 'we have an interner connection'
    else
      console.log 'no internet, its going to be tough to send emails'
  else
    if navigator.userAgent.match /like Mac OS X/i
      console.log 'user is visiting from mobile safari'
    else
      console.log 'user is visiting from android or other mobile OS'