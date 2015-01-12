class UserMailer < ApplicationMailer
  default from: 'test_sender@example.com'

  def request_email(user_id, ticket_id)
    @user = User.find(user_id)
    @ticket = Ticket.find(ticket_id)
    mail(to: @user.email, subject: 'Your request on site "http://myawesomesite.com" was created!')
  end
end