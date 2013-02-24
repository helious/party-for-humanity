class GuestController < ApplicationController
	before_filter :authenticate_user!

	def add
		@party = Party.find params[:party_id]
		@guests = @party.guests
		@guest = Guest.new params[:guest]
		@guest.party_id = @party.id

		if request.post?
			if @guest.save
				@guest = Guest.new :party_id => @party.id
			else
				flash[:warning] = 'We were unable to add the guest you entered.'
			end
		end
	end

	def edit

	end

end