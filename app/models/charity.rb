class Charity < ActiveRecord::Base
	attr_accessible :name, :category, :description, :website
	#TODO: Add validation.
end