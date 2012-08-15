//= require jquery
//= require jquery_ujs
# we can probably remove ujs here. eventually we will want to convert this to zepto

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