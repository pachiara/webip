class Notifier < ActionMailer::Base
  
  default from: "webip@lispa.it"
  
  def send_message(text, recipient, subject, sender="webip@lispa.it")
    @mail_text = text
    mail :to => recipient, :subject => subject, :from => sender
  end
  
  def send_email(email)
    @mail_text = email.text    
    mail :to => email.recipient, :subject => email.subject, :from => email.sender
  end    
  
end
