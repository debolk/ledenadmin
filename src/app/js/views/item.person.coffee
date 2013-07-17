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
		@$el.html "
			<div class='box'>
				<a data-route='/member/#{ @model.get 'uid' }'>
					<img src='#{ Bolk.BlipRequest.photo_src( @model.get( 'uid' ), 150, 150 ) }' title='#{ @model.get 'name' }'/>
				</a>
			</div>
			<a class='title' data-route='/member/#{ @model.get 'uid' }'>#{ @model.get 'name' }</a>
		"
		return this
