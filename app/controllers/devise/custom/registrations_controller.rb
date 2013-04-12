class Devise::Custom::RegistrationsController < Devise::RegistrationsController
	before_filter :age_gate_check, :only => :new

  	private
  	def age_gate_check
  		redirect_to age_gate_url if session[:age_gate].blank?
  	end

end