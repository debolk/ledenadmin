# Class for all requests to the Operculum endpoint
#
class Bolk.OperculumRequest extends Bolk.AjaxRequest
	
	@EndPoint = 'https://operculum.i.bolkhuis.nl/'
	
	# Creates a new Operculum request
	#
	# @param api [String] the api to invoke
	# @param params [Object] the parameters
	# @param method [String] the method to use
	#
	constructor: ->
		Object.defineProperty( @, 'endpoint', get: -> OperculumRequest.EndPoint )
		super true, arguments...
		
	# Runs when the request was successfull
	# 
	# @param data [Object] result data
	#
	onSuccess: ( data ) =>
		@result = data
