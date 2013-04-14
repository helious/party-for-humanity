class Devise::Custom::RegistrationsController < Devise::RegistrationsController
	before_filter :age_gate_check, :only => :new

  	private
  	def age_gate_check
  		if session[:age_gate].blank? && params[:verified].nil?
  			redirect_to age_gate_url
  		end
  	end

end