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
		
	#
	#
	render: ->
      $( @el ).html "<a href='#{ @model.get 'href' }'>#{ @model.get 'name' }</a>"