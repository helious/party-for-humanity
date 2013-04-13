module PartyHelper

	def get_donation_status(guest)
		guest.donation.blank? ? 'Undisclosed' : (guest.anonymous_donation? ? 'Undisclosed' : number_to_currency(guest.donation))
	end

	def get_rsvp_status(guest)
		guest.rsvp.nil? ? 'Awaiting RSVP' : (guest.rsvp ? 'Attending' : 'Not Attending')
	end

end