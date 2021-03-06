class PartyController < ApplicationController
	before_filter { |c|
		if params[:action] == 'view'
			c.authenticate_user! unless c.is_party_guest?
		elsif params[:action] != 'view_parties'
			c.authenticate_user!
		end
	}
	before_filter { |c|
		if params[:action] == 'edit' || params[:action] == 'destroy'
			c.assert_party_ownership params[:id] 
		end
	}

	def create
		@party = Party.new params[:party]
		@party.host = @profile.name if @party.host.blank?
	    @party.zip = @profile.zipcode if @party.zip.blank?
	    @party.user_id = current_user.id

		if request.post?

	      if @party.save
	      	if params[:attending]
	      		guest = Guest.new party_id: @party.id, email: current_user.email
	      		guest.name = current_user.profile.name unless current_user.profile.name.blank?

	      		guest.save
	      	end

	        return redirect_to view_party_path(@party.id)
	      else
	      	@party.errors.full_messages.each do |message|
	      		flash[:alert] = message
	      	end
	      end
	    end

	    setup
	end

	def view
		@party = Party.find params[:id]
		@charity = Charity.find @party.charity_id unless @party.charity_id.blank?
		@total_donation = 0
		@is_party_owner = current_user.nil? ? false : (current_user.parties.exists? :id => params[:id])
		@party.guests.each do |guest|
			@total_donation += guest.donation unless guest.donation.nil?
		end
	end

	def edit
		if request.put?
	      if Party.update params[:id], params[:party]
	      	if params[:attending] && Guest.find_by_email_and_party_id(current_user.email, params[:id]).blank?
	      		guest = Guest.new party_id: params[:id], email: current_user.email
	      		guest.name = current_user.profile.name unless current_user.profile.name.blank?

	      		guest.save
	      	end

	        return redirect_to view_party_path(params[:id])
	      end
	  	end

		@party = Party.find params[:id]

	  	setup
	end

	def destroy
		if Party.destroy params[:id]
			flash[:notice] = "Your party has been deleted!"
		else
	    	flash[:alert] = 'We were unable to delete your party at this time. Please try again in a few minutes.'
	    end

	    redirect_to my_account_path
	end

	def send_invites
		party =  Party.find_by_id params[:id]

		party.guests.each do |guest|
			unless guest.invite_sent
				Invitation.invite(guest, party).deliver

				guest.invite_sent = true

				guest.save
			end
		end

		flash[:notice] = 'Your guests have been invited via e-mail!'

		redirect_to view_party_path(params[:id])
	end

	def send_invite
		party =  Party.find_by_id params[:id]
		guest = Guest.find_by_id params[:guest_id]

		Invitation.invite(guest, party).deliver

		guest.invite_sent = true
		guest.save

		flash[:notice] = "#{guest.name || guest.email} has been invited via e-mail!"

		redirect_to view_party_path(params[:id])
	end

	def view_parties
		email = session[:guest].email unless session[:guest].nil?
		email = current_user.email unless current_user.nil?

		guests = Guest.find_by_email email

		if guests.is_a? Array
			@parties = []

			guests.each do |guest|
				@parties << Party.find_by_id(guest.party_id) 
			end
		elsif guests.is_a? Guest
			@parties = [ Party.find_by_id(guests.party_id) ]
		end
	end

	def is_party_guest?
		session[:guest] = Guest.find_by_email(Base64.decode64 params[:tk]) unless params[:tk].blank?

		unless session[:guest].nil?
			session[:guest].party_id.to_s == params[:id]
		else
			false
		end
	end

	private
	def setup
	    @charities = [['Pick a Charity!', nil]]

	    Charity.order('name').all.each do |charity|
	      charity_option = [charity.name, charity.id]
	      @charities << [charity.name, charity.id] unless @charities.include?(charity_option)
	    end

	    @party_types = [['Pick a Party Type!', '']]
	    @party_types << ['Birthday (Ages 0 to 5)', 'Birthday (Ages 0 to 5)']
	    @party_types << ['Birthday (Ages 6 to 10)', 'Birthday (Ages 6 to 10)']
	    @party_types << ['Birthday (Middle School)', 'Birthday (Middle School)']
	    @party_types << ['Birthday (High School)', 'Birthday (High School)']
	    @party_types << ['Sweet Sixteen', 'Sweet Sixteen']
	    @party_types << ['Birthday (18+)', 'Birthday (18+)']
	    @party_types << ['Graduation', 'Graduation']
	    @party_types << ['Bar Mitzvah/Bat Mitzvah', 'Bar Mitzvah/Bat Mitzvah']
	    @party_types << ["New Year's Day", "New Year's Day"]
	    @party_types << ['Martin Luther King, Jr. Day', 'Martin Luther King, Jr. Day']
	    @party_types << ['Memorial Day', 'Memorial Day']
	    @party_types << ['Independence Day', 'Independence Day']
	    @party_types << ['Labor Day', 'Labor Day']
	    @party_types << ['Columbus Day', 'Columbus Day']
	    @party_types << ["Veteran's Day", "Veteran's Day"]
	    @party_types << ['Patriot Day', 'Patriot Day']
	    @party_types << ['Flag Day', 'Flag Day']
	    @party_types << ['Arbor Day', 'Arbor Day']
	    @party_types << ['Earth Day', 'Earth Day']
	    @party_types << ['Engagement', 'Engagement']
	    @party_types << ['Birth Shower', 'Birth Shower'] 
	    @party_types << ['Wedding Shower', 'Wedding Shower']
	    @party_types << ['Wedding', 'Wedding']
	    @party_types << ['Anniversary', 'Anniversary']
	    @party_types << ['Thanksgiving', 'Thanksgiving']
	    @party_types << ['Christmas', 'Christmas']
	    @party_types << ['Hanukah', 'Hanukah']
	    @party_types << ['Kwanzaa', 'Kwanzaa']
	    @party_types << ['Easter', 'Easter']
	    @party_types << ['Passover', 'Passover']
	    @party_types << ['Mother''s Day', 'Mother''s Day']
	    @party_types << ['Father''s Day', 'Father''s Day']
	    @party_types << ['In Memoriam', 'In Memoriam']
	    @party_types << ['Halloween', 'Halloween']
	    @party_types << ['Valentine''s Day', 'Valentine''s Day']
	    @party_types << ['Other General', 'Other General']
	    @party_types << ['Other Holiday', 'Other Holiday']
	end
	
end