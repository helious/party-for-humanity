class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :omniauthable, :omniauth_providers => [:facebook, :twitter]
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :trackable, :validatable
  after_save :create_profile
  has_one :profile, :dependent => :destroy
  has_many :parties
  accepts_nested_attributes_for :profile

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :profile_attributes
  attr_accessible :provider, :uid #OAuth
  # attr_accessible :title, :body

  def self.find_for_database_authentication(conditions={})
    profile = Profile.where('username = ?', conditions[:email]).limit(1).first
    
    unless profile.nil?
      self.where('id = ?', profile.user_id).limit(1).first 
    else
      self.where('email = ?', conditions[:email]).limit(1).first
    end
  end

  def create_profile
    if self.profile.nil?
      self.profile = Profile.new
      self.profile.save
    end
  end

  def self.find_for_facebook_oauth(auth, signed_in_resource = nil)
    user = User.where(:provider => auth.provider, :uid => auth.uid).first

    unless user
      user = User.create(provider:auth.provider, uid:auth.uid, email:auth.info.email, password:Devise.friendly_token[0,20], :profile_attributes => { :name => auth.extra.raw_info.name, :username => auth.extra.raw_info.username })
    end

    user
  end

  def self.find_for_twitter_oauth(auth, signed_in_resource = nil)
    user = User.where(:provider => auth.provider, :uid => auth.uid).first

    unless user
      user = User.create(provider:auth.provider, uid:auth.uid, email:"#{auth.extra.raw_info.screen_name}@twitter.com", password:Devise.friendly_token[0,20], :profile_attributes => { :name => auth.extra.raw_info.name, :username => auth.extra.raw_info.screen_name })
    end

    user
  end

end
