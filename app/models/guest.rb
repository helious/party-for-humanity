class Guest < ActiveRecord::Base
	attr_accessible :name, :email, :address, :city, :state, :zip, :rsvp, :donation, :party_id, :invite_sent, :anonymous_donation
	validates_presence_of :email, :party_id
	validates :email, :email => true
	belongs_to :party

end