# This is the controller class for the members listing pages. 
#
class Bolk.MembersPageController extends Bolk.Controller

	# Creates the controller for the Members Listing Page
	#
	# @param filter [String] the filter, defines the request type
	#
	constructor: ( @filter ) ->
		super new Bolk.MembersPage( @_titlefor @filter )
		
	# Gets the title for a filter
	#
	# @param filter [String] the filter
	# @return [String] the title
	#
	_titlefor: ( filter ) ->
		switch filter
			when 'kandidaat'
				'Kandidaatleden'
			when 'oud'
				'Oud-leden'
			when 'actief'
				'Ledenlijst'
			else
				'Ledenlijst'
				