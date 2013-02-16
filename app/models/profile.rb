class Profile < ActiveRecord::Base
	attr_accessible :username, :name, :zipcode
	belongs_to :user

end