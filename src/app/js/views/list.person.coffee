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
			@$list.append ( li = @items[ person.get( 'uid' ) ? person.cid ].$el )
			li.attr 'id', 'person-' + ( person.get( 'uid' ) ? person.cid )
	  
	#
	#
	render: ->
		@$el.append ( @$list = $ '<ul class="members"></ul>' )
		return this

	#
	#
	remove: ->
		@$el.children().remove()
