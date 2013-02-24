class MessagesController < ApplicationController

	def create
		begin
			Message.new(params).save

			flash[:notice] = 'Thanks for the message!'

			redirect_to root_url
		rescue => e
			flash[:warning] = 'Please make sure you''ve entered a valid e-mail address!' # e.message TODO: Appropriate error messaging.

			redirect_to (params[:is_charity_suggestion] ? share_path(:params => params.encode_values_for_urls) : suggest_path(:params => params.encode_values_for_urls))
		end
	end

	def new

	end

end