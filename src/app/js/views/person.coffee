#
#
class Bolk.PersonView extends Backbone.View
	
	# Initializes a person view
	#
	initialize: ->
		_.bindAll @
		@render()
		@_bindToggle()
		@disable()
		
	# Gets the person view template
	#
	# @return [String] the template
	#
	getTemplate: ->
		'<header id="person-header">
			<div class="control-group">
				<div class="controls">
					<input class="input-big" id="name_first" name="input[blip][firstname]" placeholder="First name" maxlength="100" value="<%= firstname %>" required type="text">
					<input class="input-big" id="name_last" name="input[blip][lastname]" placeholder="Last name" maxlength="100" value="<%= lastname %>" required type="text">
					<a class="btn btn-primary btn-large" data-action="toggleEdit"><i class="icon-pencil icon-white"></i></a>
				</div>
			</div>
			
			<div class="contact">
				<label title="Mobile Phone Number">
					<i class="icon-user"></i> <input class="" id="contact_mobile" name="input[blip][mobile]" placeholder="" maxlength="20" value="<%= mobile %>" type="tel">
				</label>
				<label title="Home Phone Number">
					<i class="icon-home"></i> <input class="" id="contact_phone" name="input[blip][phone]" placeholder="" maxlength="20" value="<%= phone %>" type="tel">
				</label>
				<label title="E-Mail Address">
					<i class="icon-envelope"></i> <input class="" id="contact_email" name="input[blip][email]" placeholder="" maxlength="254" value="<%= email %>" type="email" required>
				</label>
			</div>
		</header>
		
		<div id="photo-box">
			<img src="<%= img %>"/ id="photo">
		</div>
		
		<div class="control-group">
			<label class="control-label" for="lidmaatschap">
				Lidmaatschap
			</label>
			<div class="controls">
				<select id="lidmaatschap" name="input[blip][membership]">
					<option <%= membership == "geen lid"?"selected ":"" %>value="geen lid">Geen lid</option>
					<option <%= membership == "kandidaatlid"?"selected ":"" %>value="kandidaatlid">Kandidaatlid</option>
					<option <%= membership == "lid"?"selected ":"" %>value="lid">Lid</option>
					<option <%= membership == "oudlid"?"selected ":"" %>value="oudlid">Oud-lid</option>
					<option <%= membership == "lidvanverdienste"?"selected ":"" %>value="lidvanverdienste">Lid van verdienste</option>
				</select>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label" for="initials">
				Initialen
			</label>
			<div class="controls">
				<input id="initials" name="input[blip][initials]" maxlength="20" value="<%= initials %>" type="text" pattern="[a-zA-Z]*" title="Alleen letters">
			</div>
		</div>
		<div class="control-group">
			<label class="control-label" for="gender">
				Geslacht
			</label>
			<div class="controls">
				<select id="gender" name="input[blip][gender]">
					<option value="U">Niet Aangegeven</option>
					<option <%= gender == "M"?"selected ":"" %> value="M">Man</option>
					<option <%= gender == "F"?"selected ":"" %> value="F">Vrouw</option>
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
				<textarea id="address" name="input[blip][address]" maxlength="2000" type="text"><%= address %></textarea>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label" for="dateofbirth">
				Geboortedatum
			</label>
			<div class="controls">
				<input id="dateofbirth" name="input[blip][dateofbirth]" maxlength="100" value="<%= dateofbirth %>" type="date">
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
					<option value="true" <%= alive ? "selected" : "" %>>Ja</option>
					<option value="false" <%= alive? "" : "selected" %>>Nee</option>
				</select>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label" for="inauguration">
				Inauguratiedatum
			</label>
			<div class="controls">
				<input id="inauguration" name="input[operculum][inauguration]" maxlength="100" value="<%= inauguration %>" type="date" placeholder="yyyy-mm-dd">
			</div>
		</div>
		<div class="control-group">
			<label class="control-label" for="resignation_letter">
				Lid-afbrief datum
			</label>
			<div class="controls">
				<input id="resignation_letter" name="input[operculum][resignation_letter]" maxlength="100" value="<%= resignation_letter %>" type="date" placeholder="yyyy-mm-dd">
			</div>
		</div>
		<div class="control-group">
			<label class="control-label" for="resignation">
				Lid-af
			</label>
			<div class="controls">
				<input id="resignation" name="input[operculum][resignation]" maxlength="100" value="<%= resignation %>" type="date"  placeholder="yyyy-mm-dd">
			</div>
		</div>
		<div class="control-group">
			<label class="control-label" for="submit">
				Opslaan
			</label>
			<div class="controls">
				<button id="submit" class="btn btn-primary" name="input[submit]" value="Opslaan" type="submit"><i class="icon-ok icon-white"></i> Opslaan</button>
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
			membership: @model.get 'membership'
			
			nickname : @model.get 'nickname'
			study : @model.get 'study'
			alive : @model.get 'alive'
			inauguration : @model.get 'inauguration'
			resignation_letter : @model.get 'resignation_letter'
			resignation : @model.get 'resignation'
		}
		
		console.info data
		@$el.html _.template( @getTemplate(), data )
	
	#
	#
	#
	disable: ->
		@$el.find( 'input, textarea' ).each ( i, el ) ->
			el = $( el ).prop( 'disabled', true ).css( 'display', 'none' )
			display = $( "<div id='#{ el.attr( 'id' ) }-display' class='input-display #{ el.attr 'class' }'></div>" ).html( el.val() ).insertAfter el
			
		@$el.find( 'select' ).each ( i, el ) ->
			el = $( el ).prop( 'disabled', true ).css( 'display', 'none' )
			display = $( "<div id='#{ el.attr( 'id' ) }-display' class='input-display #{ el.attr 'class' }'></div>" ).html( el.children( ':selected' ).text() ).insertAfter el
			
		@$el.find( 'button' ).prop( 'disabled', true ).css( 'display', 'none' )
		$( '[data-action="toggleEdit"]' ).data( 'state', 'disabled' )
	
	#
	#
	#
	enable: ->
		@$el.find( 'input, textarea, select' ).each ( i, el ) ->
			el = $( el ).prop( 'disabled', false ).css( 'display', 'inline-block' )
			$( "##{ el.attr( 'id' ) }-display" ).remove()
			
		@$el.find( 'button' ).prop( 'disabled', false ).css( 'display', 'inline-block' )
		$( '[data-action="toggleEdit"]' ).data( 'state', 'enabled' )
		
	_bindToggle: ->
		$( @el ).on( 'click', '[data-action="toggleEdit"]', ( event ) => 
			
			if $( event.currentTarget ).data( 'state' ) is 'enabled'
				@disable()
			else
				@enable()
		)
