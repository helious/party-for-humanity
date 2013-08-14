class MessagesController < ApplicationController

	def create
		begin
			message = params[:body].downcase

		    filthy_words = /(\bass\b|\basshole\b|\basswipe\b|\bbitch\b|\bbullshit\b|\bcock\b|\bcunt\b|\bdyke\b|\bfaggot\b|\bfuck\b|\bmotherfucker\b|\bnigga\b|\bnigger\b|\bpiss\b|\bpussy\b|\bshit\b|\bslut\b|\bspic\b|\btwat\b|\bwanker\b)/.match(message)

		    unless filthy_words.nil?
		    	flash[:alert] = 'Please make sure your message doesn''t have any profanity! Thanks.'
		    	return redirect_to (params[:is_charity_suggestion] ? share_path(:params => params.encode_values_for_urls) : suggest_path(:params => params.encode_values_for_urls))
		    end

			Message.new(params).save

			flash[:notice] = 'Thanks for the message!'

			redirect_to root_url
		rescue => e
			flash[:alert] = 'Please make sure you''ve entered a valid e-mail address!' # e.message TODO: Appropriate error messaging.

			redirect_to (params[:is_charity_suggestion] ? share_path(:params => params.encode_values_for_urls) : suggest_path(:params => params.encode_values_for_urls))
		end
	end

	def new

	end

end