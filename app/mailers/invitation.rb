class Invitation < ActionMailer::Base
	def category_header type
		"{\"category\": \"#{type}\"}"
	end

	def invite guest, party
		headers "X-SMTPAPI" => category_header(:email_party_invite)

		@guest = guest
		@party = party
		@charity = Charity.find_by_id party.charity_id

		p @guest.email

		mail :to => guest.email, :from => "party@partyforhumanity.org", :subject => "#{party.name} - You're Invited!" do |format|
			format.text
			format.html
		end
	end

	def to_parent(email)
		headers "X-SMTPAPI" => category_header(:email_to_parent)
		mail :to => email, :from => "registration@partyforhumanity.org", :subject => "Registration - We Need Parental Confirmation" do |format|
			format.text
			format.html
		end
	end
end
