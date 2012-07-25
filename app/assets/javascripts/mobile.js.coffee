//= require jquery
//= require jquery_ujs

$ ->

  $('#switch').on 'click', ->
    $('.toggle').toggle()
    false