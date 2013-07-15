class Bolk.BlipRequest extends Bolk.AjaxRequest

	@EndPoint = 'http://blip.i.bolkhuis.nl/'
	
	#
	#
	#
	constructor: ->
		Object.defineProperty( @, 'endpoint', get: -> BlipRequest.EndPoint )
		super true, arguments...
	
	#
	#
	#
	onSuccess: ( data ) =>
		@result = data
		
	#
	#
	#
	@photo: ( uid, width, height ) ->
		new BlipRequest BlipRequest.photo_api( uid, width, height )
		
	@photo_src: ( uid, width, height ) ->
		"#{Bolk.BlipRequest.EndPoint}#{BlipRequest.photo_api( uid, width, height )}?access_token=#{document.router.session.token}"
		
	@photo_api: ( uid, width, height ) ->
		"persons/#{uid}/photo/#{width}/#{height}"