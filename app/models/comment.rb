class Comment < ActiveRecord::Base
	attr_accessible :body, :date, :name, :party_id
	belongs_to :party


end