class ProfileController < ApplicationController
	before_filter :authenticate_user!, :only => [ :edit ]

	def edit
		if current_user.profile.nil?
			current_user.profile = Profile.new
			current_user.profile.save
		end

		if request.post?
			current_user.profile.username = params[:username]
			current_user.profile.name = params[:name]
			current_user.profile.zipcode = params[:zipcode]

			current_user.profile.save
		end

		@profile = current_user.profile
	end

end