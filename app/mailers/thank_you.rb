class ThankYou < ActionMailer::Base
	def thank(guest, party)
		mail :to => guest.email, :from => "#{user.email} <partyforhumanity.org>", :subject => "#{party.name} - Thank You!" do |format|
			format.text
			format.html
		end
	end
end