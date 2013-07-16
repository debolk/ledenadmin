#
#
class Bolk.PersonView extends Backbone.View
	
	# Initializes a person view
	#
	initialize: ->
		_.bindAll @
		@render()
		
	# Gets the person view template
	#
	# @return [String] the template
	#
	getTemplate: ->
		'<header>
			<div class="control-group">
				<div class="controls">
					<input class="input-big" id="name_first" name="input[blip][firstname]" placeholder="First name" maxlength="100" value="<%= firstname %>" required type="text">
					<input class="input-big" id="name_last" name="input[blip][lastname]" placeholder="Last name" maxlength="100" value="<%= lastname %>" required type="text">
					<button data-action="toggleEdit"><i class="icon-pencil"></i></button>
				</div>
			</div>
			
			<div class="contact">
				<img src="http://placehold.it/32x32.png&text=M"/> <input class="" id="contact_mobile" name="input[blip][mobile]" placeholder="" maxlength="20" value="<%= mobile %>" type="tel">
				<img src="http://placehold.it/32x32.png&text=P"/> <input class="" id="contact_phone" name="input[blip][phone]" placeholder="" maxlength="20" value="<%= phone %>" type="tel">
				<img src="http://placehold.it/32x32.png&text=E"/> <input class="" id="contact_email" name="input[blip][email]" placeholder="" maxlength="20" value="<%= email %>" type="email">
			</div>
		</header>
		
		<img src="<%= img %>"/>
		
		<div class="control-group">
			<label class="control-label" for="lidmaatschap">
				Lidmaatschap
			</label>
			<div class="controls">
				<select id="lidmaatschap">
					
				</select>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label" for="initials">
				Initialen
			</label>
			<div class="controls">
				<input id="initials" name="input[blip][initials]" maxlength="20" value="<%= initials %>" type="text">
			</div>
		</div>
		<div class="control-group">
			<label class="control-label" for="gender">
				Geslacht
			</label>
			<div class="controls">
				<select id="gender" name="input[blip][gender]">
					<option value="M">Man</option>
					<option value="F">Vrouw</option>
				</select>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label" for="phone_parents">
				Telefoon ouders
			</label>
			<div class="controls">
				<input id="phone_parents" name="input[blip][phone_parents]" maxlength="20" value="<%= phone_parents %>" type="tel">
			</div>
		</div>
		<div class="control-group">
			<label class="control-label" for="address">
				Adres
			</label>
			<div class="controls">
				<textarea id="address" name="input[blip][address]" maxlength="20" type="text"><%= address %></textarea>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label" for="dateofbirth">
				Geboortedatum
			</label>
			<div class="controls">
				<input id="dateofbirth" name="input[blip][dateofbirth]" maxlength="20" value="<%= dateofbirth %>" type="date">
			</div>
		</div>
		
		<div class="control-group">
			<label class="control-label" for="nickname">
				Bijnaam
			</label>
			<div class="controls">
				<input id="nickname" name="input[operculum][nickname]" maxlength="50" value="<%= nickname %>" type="text">
			</div>
		</div>
		<div class="control-group">
			<label class="control-label" for="study">
				Studie / Werk
			</label>
			<div class="controls">
				<input id="study" name="input[operculum][study]" maxlength="50" value="<%= study %>" type="text">
			</div>
		</div>
		<div class="control-group">
			<label class="control-label" for="alive">
				Levend
			</label>
			<div class="controls">
				<select id="alive" name="input[operculum][alive]">
					<option value="true">Ja</option>
					<option value="false">Nee</option>
				</select>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label" for="inauguration">
				Inauguratiedatum
			</label>
			<div class="controls">
				<input id="inauguration" name="input[operculum][inauguration]" maxlength="20" value="<%= inauguration %>" type="date">
			</div>
		</div>
		<div class="control-group">
			<label class="control-label" for="resignation_letter">
				Lid-afbrief datum
			</label>
			<div class="controls">
				<input id="resignation_letter" name="input[operculum][resignation_letter]" maxlength="20" value="<%= resignation_letter %>" type="date">
			</div>
		</div>
		<div class="control-group">
			<label class="control-label" for="resignation">
				Lid-af
			</label>
			<div class="controls">
				<input id="resignation" name="input[operculum][resignation]" maxlength="20" value="<%= resignation %>" type="date">
			</div>
		</div>
		<!-- etc -->'
		
	# Renders the person
	#
	render: ->
		data = {
			firstname: @model.get 'firstname'
			lastname: @model.get 'lastname'
			mobile: @model.get 'mobile'
			phone: @model.get 'phone'
			phone_parents : @model.get 'phone_parents'
			address : @model.get 'address'
			dateofbirth : @model.get 'dateofbirth'
			email: @model.get 'email'
			initials: @model.get 'initials'
			gender: @model.get 'gender'
			img: Bolk.BlipRequest.photo_src( @model.get( 'uid' ), 200, 200 )
			
			nickname : @model.get 'nickname'
			study : @model.get 'study'
			alive : @model.get 'alive'
			inauguration : @model.get 'inauguration'
			resignation_letter : @model.get 'inauguration'
			resignation : @mode.get 'resignation'
		}
		$( @el ).html _.template( @getTemplate(), data )