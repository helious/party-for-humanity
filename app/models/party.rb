class Party < ActiveRecord::Base
	belongs_to :user
	has_many :guests, :dependent => :destroy
	attr_accessible :name, :host, :party_type, 
					:location, :address, :city, :state, 
					:zip, :phone_number, :date, 
					:time, :message, :charity_id,
					:user_id

	validates_presence_of :name, :user_id

	#TODO: Validation.
end