class PartyController < ApplicationController
	before_filter { |c|
		if params[:action] == 'view'
			c.authenticate_user! unless c.is_party_guest?
		else
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
	        return redirect_to add_guest_path(@party.id)
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
	        return redirect_to my_account_path
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
		Party.find_by_id(params[:id]).guests.each do |guest|
			Invitation.invite(guest, Party.find_by_id(params[:id])).deliver unless guest.invite_sent
		end

		flash[:notice] = 'Your guests have been invited via e-mail!'

		redirect_to view_party_path(params[:id])
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

	    Charity.all.each do |charity|
	      charity_option = [charity.name, charity.id]
	      @charities << [charity.name, charity.id] unless @charities.include?(charity_option)
	    end

	    @party_types = [['Pick a Party Type!', '']]
	    @party_types << ['Birth Shower', 'Birth Shower'] 
	    @party_types << ['Birthday (Ages 0 to 5)', 'Birthday (Ages 0 to 5)']
	    @party_types << ['Birthday (Ages 6 to 10)', 'Birthday (Ages 6 to 10)']
	    @party_types << ['Birthday (Middle School)', 'Birthday (Middle School)']
	    @party_types << ['Birthday (High School)', 'Birthday (High School)']
	    @party_types << ['Birthday (18+)', 'Birthday (18+)']
	    @party_types << ['Bar Mitzvah/Bat Mitzvah', 'Bar Mitzvah/Bat Mitzvah']
	    @party_types << ['Sweet Sixteen', 'Sweet Sixteen']
	    @party_types << ['Graduation', 'Graduation']
	    @party_types << ['Engagement', 'Engagement']
	    @party_types << ['Wedding Shower', 'Wedding Shower']
	    @party_types << ['Wedding', 'Wedding']
	    @party_types << ['Anniversary', 'Anniversary']
	    @party_types << ['Christmas', 'Christmas']
	    @party_types << ['Hanukah', 'Hanukah']
	    @party_types << ['Kwanzaa', 'Kwanzaa']
	    @party_types << ['Easter', 'Easter']
	    @party_types << ['Passover', 'Passover']
	    @party_types << ['Mother''s Day', 'Mother''s Day']
	    @party_types << ['Father''s Day', 'Father''s Day']
	    @party_types << ['In Memoriam', 'In Memoriam']
	    @party_types << ['Halloween', 'Halloween']
	    @party_types << ['Other General', 'Other General']
	    @party_types << ['Other Holiday', 'Other Holiday']
	end
	
end