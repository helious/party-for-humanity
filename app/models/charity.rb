class Charity < ActiveRecord::Base
	attr_accessible :name, :category, :description, :website, :number, :donation_url
	#TODO: Add validation.
end