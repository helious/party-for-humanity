class CharityController < ApplicationController

	def list
		@charities = Charity.all
	end

	def edit
		@charity = Charity.find_by_id params[:id]
	end

	def add
		@charity = Charity.create
	end

	def update
		if Charity.update params[:id], params[:charity]
			redirect_to '/secret'
		else
			redirect_to edit_charity_path(params[:charity].id)
		end
	end

end