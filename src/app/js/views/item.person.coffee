#
#
class Bolk.PersonItemView extends Backbone.View
	
	#
	#
	tagName: 'li'
	
	#
	#
	initialize: ->
		_.bindAll @
		@render()
		
	#
	#
	render: ->
		@$el.html "<a data-route='/member/#{ @model.get 'uid' }'>#{ @model.get 'name' }</a>"
		return this