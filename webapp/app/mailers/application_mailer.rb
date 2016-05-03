class ApplicationMailer < ActionMailer::Base
  default from: ENV["SMTP_FROM"] || "from@example.com"
  layout 'mailer'
end
