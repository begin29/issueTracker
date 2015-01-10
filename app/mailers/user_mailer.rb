class UserMailer < ApplicationMailer
  default from: 'test_sender@example.com'

  def request_email(user, ticket)
    @user = user
    @ticket = ticket
    mail(to: @user.email, subject: 'Your request on site "http://myawesomesite.com" was created!')
  end
end