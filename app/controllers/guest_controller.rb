class GuestController < ApplicationController
	before_filter { |c| 
		unless params[:action] == 'destroy'
			unless c.is_guest_updating?
				c.authenticate_user!
				c.assert_party_ownership params[:party_id]
			end
		end
	}

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

	def ajax_add
		@guest = Guest.new
		@guest.party_id = params[:party_id]
		@guest.name = params[:name]
		@guest.email = params[:email]

		if request.post?
			if @guest.save
				@party = Party.find params[:party_id]
				@guests = @party.guests
			else
				@guests = nil
			end
		end
	end

	def edit
		if request.put?
			if Guest.update params[:id], params[:guest]
				redirect_to view_party_path(params[:party_id])
			end
		end

		@guest = Guest.find params[:id]
	end

	def update
		unless Guest.update params[:id], params[:guest]
			flash[:alert] = 'We were unable update your guest\'s status.'
		end

		session[:guest] = Guest.find_by_id session[:guest].id unless session[:guest].nil?
		redirect_to view_party_path(params[:party_id])
	end

	def destroy
		unless Guest.destroy params[:id]
			flash[:alert] = 'We were unable remove your guest.'
		end

		redirect_to view_party_path(params[:party_id])
	end

	def is_guest_updating?
		p '##########'
		p params[:action]
		if params[:action] == 'update'
			p 'AM I SESSION GUEST?'
			p !session[:guest].nil? && Party.find_by_id(params[:party_id]).guests.include?(session[:guest])
			!session[:guest].nil? && Party.find_by_id(params[:party_id]).guests.include?(session[:guest])
		else
			false
		end
	end

end