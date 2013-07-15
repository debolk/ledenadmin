# The base of all controllers
#
class Bolk.PageController extends Bolk.Controller
	
	# Creates the controller
	#
	# @param view [View.*] the view
	#
	constructor: ( view ) ->
		super view
		$( 'body' ).on( 'click', '[data-route]', @navigate )
	
	# Kills the controller
	#
	# @return [self] the chainable self
	#
	kill: ->
		super
		$( 'body' ).off( 'click', '[data-route]', @navigate )
		return this
	
	# Navigate to another page
	#
	# @param event [jQuery.Event] the event raised
	# @return [Boolean] the event source execution
	#	
	navigate: ( event ) ->
		document.router.navigate '/' + $( event.currentTarget ).data( 'route' ), { trigger: true }
		event.stopPropagation()
		event.preventDefault()
		return false
		
	showLoader: ->
		
	
	hideLoader: ->