jQuery( document ).ready( () ->

	# Window events
	#
	$( window )
		.on( 'beforeunload', () ->
			if document.router? and document.router.controller? and document.router.controller.beforeUnload?
				console.info 'Just before unloading this window...'
				message = document.router.controller.beforeUnload()
				return message if message?
			return undefined
		)
		.on( 'unload', () ->
			if document.router? and document.router.controller? and document.router.controller.onUnload?
				console.info '...unloaded this window'
				document.router.controller.onUnload()
		)
		
		
	document.router = new Bolk.AppRouter()
)