class Profile < ActiveRecord::Base
	attr_accessible :username, :name, :zipcode
	belongs_to :user

	validates_uniqueness_of :username, :unless => Proc.new { |model| model.username.blank? }
end