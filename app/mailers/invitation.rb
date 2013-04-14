class Invitation < ActionMailer::Base
	def invite(guest, party)
		@guest = guest
		@party = party

		guest.invite_sent = true
		guest.save

		@charity = Charity.find_by_id party.charity_id

		mail :to => guest.email, :from => "#{party.user.email} <partyforhumanity.org>", :subject => "#{party.name} - You're Invited!" do |format|
			format.text
			format.html
		end
	end

	def to_parent(email)
		mail :to => email, :from => "Registration <registration@partyforhumanity.org>", :subject => "Registration - We Need Parental Confirmation" do |format|
			format.text
			format.html
		end
	end
end