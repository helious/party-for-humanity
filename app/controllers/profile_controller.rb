class ProfileController < ApplicationController
	before_filter :authenticate_user!, :only => [ :edit ]

	def edit
		if request.post?
			@profile.username = params[:username]
			@profile.name = params[:name]
			@profile.zipcode = params[:zipcode]

			redirect_to my_account_path if @profile.save
		end
	end

end