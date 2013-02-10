class StaticController < ApplicationController
  before_filter :authenticate_user!, :only => :organize

  def home
  end
  
  def learn
  end
  
  def choose
    @charities = Charity.where '(name LIKE :name or description LIKE :name) and category LIKE :category', { :name => "%#{params[:keyword]}%", :category => "%#{params[:category]}%" }
    
    @charity_categories = [['...or choose a category!', '']]

    @charities.each do |charity|
      charity_option = [charity.category, charity.category]
      @charity_categories << [charity.category, charity.category] unless @charity_categories.include?(charity_option)
    end
  end
  
  def organize
  end
  
  def share
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
  
  def contact
  end
  
end