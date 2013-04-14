PartyForHumanity::Application.routes.draw do
  devise_for :users, :controllers => { :omniauth_callbacks => 'users/omniauth_callbacks', :registrations => 'devise/custom/registrations' }

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
  match '/age-gate' => 'static#age_gate', :as => :age_gate

  #Guest
  match '/guest/party/:party_id' => 'guest#add', :as => :add_guest
  post '/guest/party/:party_id' => 'guest#add'
  match '/guest/:id/party/:party_id' => 'guest#edit', :as => :edit_guest
  put '/guest/:id/party/:party_id' => 'guest#edit'
  put '/guest/party/:id/:party_id' => 'guest#update', :as => :update_guest

  #Charities
  match '/choose' => 'static#choose', :as => :choose
  post '/choose' => 'static#choose'
  get '/secret' => 'charity#list'
  get '/secret/add' => 'charity#add', :as => :add_charity
  get '/secret/:id' => 'charity#edit', :as => :edit_charity
  put '/secret/:id' => 'charity#update', :as => :charity

  #Profile
  match '/profile/edit' => 'profile#edit', :as => :edit_profile

  #Parties
  put '/party/edit/:id' => 'party#edit'
  get '/party/:id' => 'party#view', :as => :view_party
  get '/party/edit/:id' => 'party#edit', :as => :edit_party
  get '/party/:id/send-invites' => 'party#send_invites', :as => :send_party_invites
  match '/organize' => 'party#create', :as => :organize
  post '/organize' => 'party#create', :as => :parties

  #Comments
  post '/comment/:id' => 'comment#post'
  post '/comment/:party_id/:id' => 'comment#delete'

  #Messages.
  match '/share' => 'messages#new', :as => :share
  match '/suggest' => 'messages#new', :as => :suggest
  post '/message' => 'messages#create', :as => :send_message
end
