# Class for all requests to the Blip endpoint
#
class Bolk.BlipRequest extends Bolk.AjaxRequest

	@EndPoint = 'https://people.i.bolkhuis.nl/'
	
	# Creates a new blip request
	#
	# @param api [String] the api to invoke
	# @param params [Object] the parameters
	# @param method [String] the method to use
	#
	constructor: ->
		Object.defineProperty( @, 'endpoint', get: -> BlipRequest.EndPoint )
		super true, arguments...
	
	# Runs when the request was successfull
	# 
	# @param data [Object] result data
	#
	onSuccess: ( data ) =>
		@result = data
		
	# Gets a request for a photo
	#
	# @param uid [String] the uid of the photo's owner/subject
	# @param width [Integer] the width in pixels
	# @param height [Integer] the height in pixels
	# @return [Bolk.BlipRequest] the request
	#
	@photo: ( uid, width, height ) ->
		new BlipRequest BlipRequest.photo_api( uid, width, height )
		
	# Gets the photo src url for a person with uid
	#
	# @param uid [String] the uid of the photo's owner/subject
	# @param width [Integer] the width in pixels
	# @param height [Integer] the height in pixels
	# @return [Bolk.BlipRequest] the request
	#
	@photo_src: ( uid, width, height ) ->
		"#{Bolk.BlipRequest.EndPoint}#{BlipRequest.photo_api( uid, width, height )}?access_token=#{document.router?.session?.token}"
		
	# Gets the photo api url for a person with uid
	#
	# @param uid [String] the uid of the photo's owner/subject
	# @param width [Integer] the width in pixels
	# @param height [Integer] the height in pixels
	# @return [Bolk.BlipRequest] the request
	#
	@photo_api: ( uid, width, height ) ->
		"persons/#{uid}/photo/#{width}/#{height}"
