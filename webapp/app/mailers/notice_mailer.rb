class NoticeMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.notice_mailer.sendmail_enterance_exit.subject
  #
  def sendmail_enterance_exit student, time
    @student = student
    @time = time
    mail to: @student.mail, subject: "打刻のお知らせ"
  end
end
