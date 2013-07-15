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
	@photo: ( uid, width, heigth ) ->
		new BlipRequest BlipRequest.photo_src( uid, width, height )
		
	@photo_src: ( uid, width, height ) ->
		"persons/#{uid}/photo/#{width}/#{height}"