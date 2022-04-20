class UserMailer < ApplicationMailer

	def checkout_email(usr)
		@email = usr
		mail(to: @email.email, subject: "Cart Details")

	end
end
