class NoticeMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.notice_mailer.sendmail_enterance_exit.subject
  #
  def sendmail_enterance_exit mail, student_name, timestamp
    config = SmtpConfig.get()
    unless config.smtp
      //# TODO:
      raise "Not set smtp config"
    else
      unless config.smtp["address"]
        raise "Not set smtp config"
      end
    end
    timestr = timestamp.strftime('%H:%M')
    if config.body
      body = config.body.gsub(/{{student_name}}/, student_name)
      body = body.gsub(/{{timestamp}}/, timestr)
    end
    options = config.smtp.symbolize_keys
    mail(
      to: mail,
      from: config.from,
      subject: config.subject,
      body: body,
      content_type: "text/plain",
      delivery_method_options: options,
    )
  end
end
