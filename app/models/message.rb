class Message < ActiveRecord::Base
	attr_accessible :name, :email, :body, :sent, :is_charity_suggestion
	validates_presence_of :name, :email, :body
	
	#TODO: Add validation.
end