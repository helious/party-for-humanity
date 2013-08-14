class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :create_profile_reference, :if => Proc.new { user_signed_in? }
  before_filter :assign_common_globals, :clear_session_guest_if_logged_in
  before_filter :clean_params_of_default_rails_form_param_additions, :if => Proc.new { params[:controller] == 'messages' }

  def assign_common_globals
    @controller = params[:controller]
  end
  
  def clean_params_of_default_rails_form_param_additions
  	[:utf8, :authenticity_token, :commit, :controller, :action].each { |v| params.delete v }

  	params.delete_if { |v| v.blank? }
  end

  def create_profile_reference
    @profile = current_user.profile
  end

  def assert_party_ownership(party_id)
    unless current_user.parties.exists? :id => party_id
      flash[:alert] = 'You can only view/edit your parties.'
      @is_party_owner = false
      redirect_to my_account_path
    else
      @is_party_owner = true
    end
  end

  def clear_session_guest_if_logged_in
    session.delete :guest unless current_user.nil?
  end

end
