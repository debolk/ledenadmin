class Bolk.HomePage extends Bolk.Page
	
	constructor: ->
		super 'Home'
		
		actions = []
		actions.push { link: '#/leden', text: 'Ledenlijst' }
		actions.push { link: '#/leden/oud', text: 'Oud-leden' }
		actions.push { link: '#/leden/kandidaat', text: 'Kandidaatleden' }
		
		@contents.append( @_createActions actions )