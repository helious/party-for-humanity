class PartyController < ApplicationController
	before_filter :authenticate_user!

	def create
		@party = Party.new params[:party]

		if request.post?
	      if @party.save
	        return redirect_to add_guest_path(@party.id)
	      end
	    end

	    setup
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

	private
	def setup
	    @party.host = @profile.name if @party.host.blank?
	    @party.zip = @profile.zipcode if @party.zip.blank?
	    @party.user_id = current_user.id

	    @charities = [['', 0]]

	    Charity.all.each do |charity|
	      charity_option = [charity.name, charity.id]
	      @charities << [charity.name, charity.id] unless @charities.include?(charity_option)
	    end

	    @party_types = [['', '']]
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