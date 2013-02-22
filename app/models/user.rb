class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable
  after_save :create_profile
  has_one :profile
  accepts_nested_attributes_for :profile

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :profile_attributes
  # attr_accessible :title, :body

  def self.find_for_database_authentication(conditions={})
    profile = Profile.where("username = ?", conditions[:email]).limit(1).first
    
    unless profile.nil?
      self.where("id = ?", profile.user_id).limit(1).first 
    else
      self.where("email = ?", conditions[:email]).limit(1).first
    end
  end

  def create_profile
    if self.profile.nil?
      self.profile = Profile.new({ :username => '', :name => '', :zipcode => '' })
      self.profile.save
    end
  end

end
