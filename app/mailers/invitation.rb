class Invitation < ActionMailer::Base
	def invite(guest, party)
		@guest = guest
		@party = party

		@charity = Charity.find_by_id party.charity_id

		mail :to => guest.email, :from => "#{party.user.email} <partyforhumanity.org>", :subject => "#{party.name} - You're Invited!" do |format|
			format.text
			format.html
		end
	end
end