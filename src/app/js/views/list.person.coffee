#
#
class Bolk.PersonListView extends Backbone.View

	#
	#
	initialize: ->
		_.bindAll @
		@render()
		
		@items = {}
		
		@model.forEach ( person ) =>
			@items[ person.get( 'uid' ) ? person.cid ] = new Bolk.PersonItemView( { model: person } )
			@$list.append @items[ person.get( 'uid' ) ? person.cid ].$el
	  
	#
	#
	render: ->
		@$el.append ( @$list = $ '<ul class="members"></ul>' )
		return this