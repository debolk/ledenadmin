doRequest = ( event ) -> 
	elem = $ event.target
	
	# Create a new request
	namespace = ( exports ? window ? this )[ "Bolk" ]
	request = new namespace[ elem.data 'endpoint' ]( elem.data( 'api' ), elem.data( 'params' ), elem.data( 'method' ) )
	
	# Push the state
	window.history.pushState( request.statify() , document.title, elem.attr( 'href' ) )
	
	# Stop the link
	event.preventDefault()
	return false
	

jQuery( document ).ready( () ->
	$( '[data-endpoint]' ).each( ( i, elem ) ->
		$( elem ).on( 'click', doRequest )
	)
)