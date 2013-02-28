class Invitation < ActionMailer::Base
	def invite(guest, party)
		mail :to => guest.email, :from => "#{user.email} <partyforhumanity.org>", :subject => "#{party.name}" do |format|
			format.text
			format.html
		end
	end
end