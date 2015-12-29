require 'array'
module Admin::DailyReportsHelper
  def grade_list
    %w"小１ 小2 中１ 中2 中３"
  end

  def subject_list
    %w"英語 数学 理科 国語"
  end

  def student_list

    students = []
    Student.all.each do |student|
      students.push({"student_id"=> student.id.to_s, "name" => student.fullname, "attendance" => false, "test_result"=> "", "test_file" => ""})
    end
    if @daily_report.students and @daily_report.students.length >= 1
      students.merge_by_index_to_s(@daily_report.students,"student_id", "student_id")
    else
      students
    end
  end

  def text_list
    [["text1","text1"], ["text2","text2"], ["text3","text3" ],["text4","text4"]]
  end

  def homeworks
    if @daily_report.homeworks and @daily_report.homeworks.length >= 1
      @daily_report.homeworks
    else
      @daily_report.homeworks = [
        {"textbook"=> "text2", "unit"=>"", "page"=> "", "due_date"=> "", "students"=> [], "memo"=> ""}
      ]
    end
  end

  def contents
    if @daily_report.contents and @daily_report.contents.length >= 1
      @daily_report.contents
    else
      @daily_report.contents = [
        {"textbook"=> "text2", "unit"=>"", "page"=> "", "students"=> [], "memo"=>""}
      ]
    end
  end

  def blackboards
    if @daily_report.blackboard_pics and @daily_report.blackboard_pics.length >= 1
      @daily_report.blackboard_pics
    else
      []
    end
  end
end
