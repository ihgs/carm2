require 'test_helper'

class NoticeMailerTest < ActionMailer::TestCase
  setup do
    DatabaseCleaner.clean
    @student = create(:student)
    @time = Time.new(2000,1,1,10,11)
  end

  test "sendmail_enterance_exit" do
    smtp_config = create(:smtp_config)
    smtp_config.subject = "打刻のお知らせ"
    smtp_config.body = "#{@student.fullname}さんが10:11に打刻しました"
    smtp_config.save!

    mail = NoticeMailer.sendmail_enterance_exit(@student.mail, @student.fullname, @time)
    assert_equal "打刻のお知らせ", mail.subject
    assert_equal [@student.mail], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_equal "#{@student.fullname}さんが10:11に打刻しました", mail.body.raw_source
  end

  test "should raise Execption" do
    exception = assert_raises(RuntimeError) do
      mail = NoticeMailer.sendmail_enterance_exit(@student.mail, @student.fullname, @time)
      puts mail
    end
    assert_equal( "Not set smtp config", exception.message )
  end


end
