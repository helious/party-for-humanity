class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :clean_params_of_default_rails_form_param_additions, :if => Proc.new { params[:controller] == 'messages' }

  def clean_params_of_default_rails_form_param_additions
  	[:utf8, :authenticity_token, :commit, :controller, :action].each { |v| params.delete v }

  	params.delete_if { |v| v.blank? }
  end

end
