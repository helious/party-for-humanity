class MessagesController < ApplicationController

	def create
		begin
			Message.new(params).save

			flash[:notice] = 'Thanks for the message!'

			redirect_to root_url
		rescue => e
			flash[:warning] = 'Please make sure you''ve entered a valid e-mail address!' # e.message TODO: Appropriate error messaging.

			params.delete :is_charity_suggestion

			redirect_to (params[:is_charity_suggestion] ? share_path(:params => params.encode) : suggest_path(:params => params.encode))
	#	rescue => e
	#		flash[:notice] = 'What are you trying to do?'

	#		redirect_to root_url
		end
	end

end