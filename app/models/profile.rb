class Profile < ActiveRecord::Base
	attr_accessible :username, :name, :zipcode
	belongs_to :user

	validates_uniqueness_of :username

	before_save :nil_out

	private
	def nil_out
		self.username = nil if self.username.blank?
		self.name = nil if self.name.blank?
		self.zipcode = nil if self.zipcode.blank?
	end
end