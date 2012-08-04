//= require jquery
//= require jquery_ujs

$ ->

  # flip the page when the cog is clicked
  $('.cog').on 'click', ->
    $('.toggle').toggle()
    false

  # slide down the note section
  $('#write-note').on 'click', ->
    $(@).css height: 100
  .on 'keydown', ->
    $(@).css textAlign: 'left'