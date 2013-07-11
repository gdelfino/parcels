<% if @shipment.errors.any? %>

$('#error_explanation').remove()
$('.field').before("<%= escape_javascript render(partial: 'errors', locals: { shipment: @shipment }) %>")
$('#error_explanation').hide().slideDown()

<% else %>

$('#error_explanation').remove()

$('<%= escape_javascript(render(:partial => @shipment))%>')
  .prependTo('#shipments')
  .hide()
  .fadeIn("slow")

<% end %>