PartyForHumanity::Application.routes.draw do
  devise_for :users

  root :to => 'static#home'
  
  match '/learn' => 'static#learn', :as => :learn
  match '/choose' => 'static#choose', :as => :choose
  match '/organize' => 'static#organize', :as => :organize
  match '/who-we-are' => 'static#who_we_are', :as => :who_we_are
  match '/board' => 'static#board', :as => :board
  match '/donate' => 'static#donate', :as => :donate
  match '/directors-letter' => 'static#directors_letter', :as => :directors_letter
  match '/financial-statements' => 'static#financial_statements', :as => :financial_statements
  match '/privacy' => 'static#privacy', :as => :privacy
  match '/share' => 'static#contact', :as => :share
  match '/suggest' => 'static#contact', :as => :suggest

  post '/message' => 'messages#create', :as => :send_message
end
