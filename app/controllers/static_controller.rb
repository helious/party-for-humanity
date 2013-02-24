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
  
end