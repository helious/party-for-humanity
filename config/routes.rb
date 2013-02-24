PartyForHumanity::Application.routes.draw do
  devise_for :users

  #"Static"
  root :to => 'static#home'
  
  match '/learn' => 'static#learn', :as => :learn
  match '/who-we-are' => 'static#who_we_are', :as => :who_we_are
  match '/board' => 'static#board', :as => :board
  match '/donate' => 'static#donate', :as => :donate
  match '/directors-letter' => 'static#directors_letter', :as => :directors_letter
  match '/financial-statements' => 'static#financial_statements', :as => :financial_statements
  match '/privacy' => 'static#privacy', :as => :privacy
  match '/account' => 'static#account', :as => :my_account
  match '/party' => 'static#party', :as => :party

  #Guest
  match '/party/:party_id/guest' => 'guest#add', :as => :add_guest
  post '/party/:party_id/guest' => 'guest#add', :as => :guests
  match '/party/:party_id/guest/:id' => 'guest#edit', :as => :edit_guest
  put '/party/:party_id/guest/:id' => 'guest#edit'

  #Charities
  match '/choose' => 'static#choose', :as => :choose
  post '/choose' => 'static#choose'

  #Profile
  match '/profile/edit' => 'profile#edit', :as => :edit_profile

  #Parties
  put '/party/edit/:id' => 'party#edit'
  get '/party/edit/:id' => 'party#edit', :as => :edit_party
  match '/organize' => 'party#create', :as => :organize
  post '/organize' => 'party#create', :as => :parties

  #Messages.
  match '/share' => 'messages#new', :as => :share
  match '/suggest' => 'messages#new', :as => :suggest
  post '/message' => 'messages#create', :as => :send_message
end
