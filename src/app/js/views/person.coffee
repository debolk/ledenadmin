#
#
class Bolk.PersonView extends Backbone.View
	
	# Initializes a person view
	#
	initialize: ->
		_.bindAll @
		
	# Gets the person view template
	#
	# @return [String] the template
	#
	getTemplate: ->
		'<header>
			<div class="control-group">
				<div class="controls">
					<input class="input-big" id="name_first" name="input[blip][firstname]" placeholder="First name" maxlength="100" value="<%= firstname %>" required="" type="text">
					<input class="input-big" id="name_last" name="input[blip][lastname]" placeholder="Last name" maxlength="100" value="<%= lastname %>" required="" type="text">
					<button data-action="toggleEdit"><i class="icon-pencil"></i></button>
				</div>
			</div>
			
			<div class="contact">
				<img src="//placehold.it/32x32.png&text=P"/> <input class="" id="contact_phone" name="input[blip][phone]" placeholder="" maxlength="20" value="<%= phone %>" required="" type="tel">
				<img src="//placehold.it/32x32.png&text=H"/> <input class="" id="contact_phone_home" name="input[blip][phone_parents]" placeholder="" maxlength="20" value="<%= phone_parents %>" required="" type="tel">
				<img src="//placehold.it/32x32.png&text=E"/> <input class="" id="contact_email" name="input[blip][email]" placeholder="" maxlength="20" value="<%= email %>" required="" type="tel">
			</div>
		</header>
		
		<div class="control-group">
			<label class="control-label" for="lidmaatschap">
				Lidmaatschap
			</label>
			<div class="controls">
				<select id="lidmaatschap">
					
				</select>
			</div>
		</div>
		<!-- etc -->'
		
	# Renders the person
	#
	render: ->
		data = {
			firstname: @model.get 'firstname'
			lastname: @model.get 'lastname'
			phone: @model.get 'phone'
			phone_parents : @model.get 'phone_parents'
			email: @model.get 'email'
		}
		$( @el ).html _.template( @getTemplate(), data )