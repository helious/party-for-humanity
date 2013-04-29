class User < ActiveRecord::Base
  # To use devise-twitter don't forget to include the :twitter_oauth module:
  # e.g. devise :database_authenticatable, ... , :twitter_oauth

  # IMPORTANT: If you want to support sign in via twitter you MUST remove the
  #            :validatable module, otherwise the user will never be saved
  #            since it's email and password is blank.
  #            :validatable checks only email and password so it's safe to remove

  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :omniauthable, :omniauth_providers => [:facebook]
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable
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
      self.profile = Profile.new({ :username => '', :name => '', :zipcode => '' })
      self.profile.save
    end
  end

  def self.find_for_facebook_oauth(auth, signed_in_resource = nil)
    user = User.where(:provider => auth.provider, :uid => auth.uid).first

    unless user
      user = User.create(provider:auth.provider, uid:auth.uid, email:auth.info.email, password:Devise.friendly_token[0,20])

      user.profile.name = auth.extra.raw_info.name
      user.profile.username = auth.extra.raw_info.username

      Rails.logger.info auth.extra.raw_info

      user.profile.save
    end

    user
  end

end
