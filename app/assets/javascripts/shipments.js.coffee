# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

jQuery ->
  fb = $('form.button_to')
  fb.attr('action')
  fb.after("<a href='" + $('form.button_to').attr('action') + "' data-method='delete' rel='nofollow'>⌫</a>")
  fb.remove()