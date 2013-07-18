# Base class for all Ajax Requests
#
class Bolk.AjaxRequest
	
	# Creates a new Ajax Request
	# 
	# @param api [String] the api to invoke
	# @param params [Object] the parameters
	# @param method [String] the method to use
	#
	constructor: ( @secure = true, @api , @params = {}, @method = 'get' ) ->
		console.debug "#{ @method } #{ @url() }"
		if not @params[ 'access_token' ] and @secure
			@api = @api + '?access_token=' + document.router.session.token
		@result = undefined
		console.log @method
		@request = @execute()
		
	# Gets the url for this request
	#
	# @return [String] the url
	#
	url: -> 
		"#{ @endpoint }#{ @api }"
		
	# Gets the request options
	# 
	# @return [Object] the options
	#
	options: ->
		{
			url: @url()
			type: @method
			data: @params 
		}
		
	# Executes the rquest
	#
	# @return [jQuery.Promise] the AJAX promise
	#
	execute: ->
		jQuery.ajax( @options() )
			.done( @onSuccess )
			.fail( @onFail )
			.always( @onDone )
	
	# Runs when the request was successfull
	# 
	# @param data [Object] result data
	#
	onSuccess: ( data ) ->
		console.log data
	
	# Runs when the request failed
	#
	# @param error [Object] error data
	#
	onFail: ( error ) =>
		console.error "Error occurred on request #{ @statify() }"
		console.error error.statusText
		console.error error
	
	# Runs regardless of the request completion success/fail status
	# 
	onDone: ->
		
	# Creates a state object from this ajax request
	#
	# @return [Object] the statified request
	#
	statify: () ->
		JSON.stringify { 
			api: @api
			method: @method
			endpoint: @endpoint
			params: @params
		}
		
	# Generates a request from an statified request
	#
	# @param state [Object] the statified request
	# @return [Bolk.AjaxRequest] the request
	#
	@generate: ( state ) ->
		state = JSON.parse state if state instanceof String
		request = new AjaxRequest( state.api, state.method )
		Object.defineProperty( request, 'endpoint', get: -> state.endpoint )
		return request
	
	
