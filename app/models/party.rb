class NonNegativeValidator < ActiveModel::Validator
	def validate record
		record.errors[:base] << 'Please choose a goal greater than $0.' if (!record.goal.nil? && record.goal < 0)
	end
end

class Party < ActiveRecord::Base
	include ActiveModel::Validations
	belongs_to :user
	has_many :guests, :dependent => :destroy
	has_many :annoucements, :dependent => :destroy
	has_many :comments, :dependent => :destroy
	attr_accessible :name, :host, :party_type, 
					:location, :address, :city, :state, 
					:zip, :phone_number, :date, 
					:time, :message, :charity_id,
					:user_id, :goal, :end_time

	validates_presence_of :name, :user_id, :goal, :host, :charity_id
	validates_with NonNegativeValidator

	#TODO: Validation.
end