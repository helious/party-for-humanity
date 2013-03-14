class GuestController < ApplicationController
	before_filter :authenticate_user!
	before_filter { |c| c.assert_party_ownership params[:party_id] }

	def add
		@party = Party.find params[:party_id]
		@guests = @party.guests
		@guest = Guest.new params[:guest]
		@guest.party_id = @party.id

		if request.post?
			if @guest.save
				@guest = Guest.new :party_id => @party.id
			else
				@guest.errors.full_messages.each do |message|
					flash[:alert] = message
				end
			end
		end
	end

	def edit
		if request.put?
			if Guest.update params[:id], params[:guest]
				redirect_to add_guest_path(params[:party_id])
			end
		end

		@guest = Guest.find params[:id]
	end

	def update
		unless Guest.update params[:id], params[:guest]
			flash[:alert] = 'We were unable update your guest\'s status.'
		end

		redirect_to view_party_path(params[:party_id])
	end

end