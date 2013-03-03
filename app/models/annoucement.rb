class Annoucement < ActiveRecord::Base
	belongs_to :party
	attr_accessible :body, :party_id

end