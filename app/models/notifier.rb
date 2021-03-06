class Notifier < ActionMailer::Base
  
  def contact_us_message(message)
    subject       "Contact Us:: #{message.subject}"
    from          message.email
    recipients    APP_CONFIG['contact_us_recipients']
    sent_on       Time.now
    body          :message => message
    content_type  "text/html"
  end

end
