class Message < ActiveRecord::Base
	attr_accessible :name, :email, :body, :sent, :is_charity_suggestion
	#TODO: Add validation.
end