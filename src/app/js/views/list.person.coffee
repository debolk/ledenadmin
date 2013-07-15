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
			@items[ person.get( 'uid' ) ? person.cid ] = new Bolk.PersonItemView( { el: @model.el, model: person } )
			@$el.append @items[ person.get( 'uid' ) ? person.cid ].$el
	  
	#
	#
	render: ->
		$( @el ).append '<ul class="members"></ul>'
		return this