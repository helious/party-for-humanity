class StaticController < ApplicationController
  before_filter :authenticate_user!, :only => :organize

  def home
  end
  
  def learn
  end
  
  def choose
    @charities = Charity.all
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