class Notifier < ActionMailer::Base
  default from: "webip@lispa.it"

  def send_email(email)
    @mail_text = email.text
    mail to: email.recipient, subject: email.subject, from: email.sender, cc: email.cc
  end

end
