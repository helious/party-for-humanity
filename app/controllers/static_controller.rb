class StaticController < ApplicationController
  before_filter :authenticate_user!, :only => [ :account ]

  def home
  end
  
  def learn
  end
  
  def choose
    @charities = Charity.where '(LOWER(name) LIKE :name or LOWER(description) LIKE LOWER(:name)) and category LIKE :category', { :name => "%#{params[:keyword]}%", :category => "%#{params[:category]}%" }
    
    @charity_categories = [['...or choose a category!', '']]

    Charity.all.each do |charity|
      charity_option = [charity.category, charity.category]
      @charity_categories << [charity.category, charity.category] unless @charity_categories.include?(charity_option)
    end
  end
  
  def who_we_are
  end
  
  def board
  end
  
  def donate
  end
  
  def directors_letter
  end
  
  def financial_statements
  end
  
  def privacy
  end

  def account
  end
  
  def party
  end
  
  def age_gate
    @old_enough = (DateTime.now - DateTime.civil(params[:"date(1i)"].to_i, params[:'date(2i)'].to_i, params[:'date(3i)'].to_i)).to_i > 365 * 13 unless params[:"date(1i)"].blank?

    if @old_enough
      session[:age_gate] = true
      redirect_to new_user_registration_path
    end

    unless params[:email].blank?
      Invitation.to_parent(params[:email]).deliver

      flash[:notice] = 'An e-mail has been sent to your parents!'

      redirect_to root_url
    end
  end

end