require 'array'
module Admin::DailyReportsHelper

  def student_list student_list, attendance=false

    students = []
    student_list.each do |student|
      students.push({"student_id"=> student.id.to_s, "name" => student.fullname, "attendance" => attendance, "test_result"=> "", "test_file" => ""})
    end
    if @daily_report.students and @daily_report.students.length >= 1
      students.merge_by_index_to_s(@daily_report.students,"student_id", "student_id")
    else
      students
    end
  end

  def text_list
    Textbook.all
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

  def test_results
    if @daily_report.test_result_pics and @daily_report.test_result_pics.length >= 1
      @daily_report.test_result_pics
    else
      []
    end
  end
end
