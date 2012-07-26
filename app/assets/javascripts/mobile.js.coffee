//= require jquery
//= require jquery_ujs

$ ->

  $('.cog').on 'click', ->
    $('.toggle').toggle()
    false

  $('#add-note').on 'click', ->
    $('#write-note').show().css('display', 'block')
    $('#add-note').hide()
    false