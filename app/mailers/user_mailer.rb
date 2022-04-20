class UserMailer < ApplicationMailer

	def checkout_email(usr,cart)
		@email = usr
		@your_cart= cart
		mail(to: @email.email, subject: "Cart Details")

	end
end
