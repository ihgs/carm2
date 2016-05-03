require 'test_helper'

class NoticeMailerTest < ActionMailer::TestCase
  setup do
    @student = create(:student)
    @time = Time.now
  end
  test "sendmail_enterance_exit" do
    mail = NoticeMailer.sendmail_enterance_exit(@student, @time)
    puts @student
    assert_equal "打刻のお知らせ", mail.subject
    assert_equal [@student.mail], mail.to
    assert_equal ["from@example.com"], mail.from
  end

end
