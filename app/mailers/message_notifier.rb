class ApplicationMailer < ActionMailer::Base
  default "test_sender@example.com"
  layout 'mailer'
end

# class ApplicationMail < ActionMailer::Base
#   include ActionView::Helpers::SanitizeHelper
#   default from: "test_sender@example.com"

#   def notification msg
#     mail(to: msg.recipient, subject: msg.subject) do |format|
#       format.text { render text: strip_tags(msg.body.html_safe).gsub(/&nbsp;/ || /&nbsp/ , ' ') }
#       format.html { render text: msg.body.html_safe }
#     end
#   end
# end