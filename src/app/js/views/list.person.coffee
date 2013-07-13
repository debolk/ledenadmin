#
#
class Bolk.PersonListView extends Backbone.View

	constructor: ( @el ) ->
		super
    
	#
	#
    initialize: ->
      _.bindAll @
      
      @collection = new Bolk.Persons
      @render()
    
	#
	#
    render: ->
      $( @el ).append '<ul></ul>'