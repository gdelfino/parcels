el = $('#new_shipment')

<% if @shipment.errors.any? %>

# Create a list of errors
# errors = $('<ul />')
errors = $('#aqui')


<% @shipment.errors.full_messages.each do |error| %>
errors.append('<li><%= escape_javascript( error ) %></li>')
<% end %>

# Display errors on form
el.find('.errors').html(errors)

<% else %>

$('<%= escape_javascript(render(:partial => @shipment))%>')
  .appendTo('#shipments')
  .hide()
  .fadeIn()

<% end %>