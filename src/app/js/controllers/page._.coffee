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
	kill: ->
		super
		$( 'body' ).off( 'click', '[data-route]', @navigate )
		return this
	
	#		
	#
	#	
	navigate: ( event ) ->
		document.router.navigate '/' + $( event.currentTarget ).data( 'route' ), { trigger: true }
		event.stopPropagation()
		event.preventDefault()
		return false