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
		@$el.html "<a data-route='/member/#{ @model.get 'uid' }'>
			<img src='#{ Bolk.BlipRequest.EndPoint + Bolk.BlipRequest.photo_src( @model.get( 'uid' ), 100, 100 ) }'/>
			<span>#{ @model.get 'name' }</span>
		</a>"
		return this