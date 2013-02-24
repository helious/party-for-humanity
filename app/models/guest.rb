class Guest < ActiveRecord::Base
	attr_accessible :name, :email, :address, :city, :state, :zip, :rsvp, :donation, :party_id
	validates_presence_of :email, :party_id
	belongs_to :party

end