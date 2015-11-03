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
      students.push({student_id: student.id, name: student.fullname, attendance: false, test_result: "", test_file: ""})
    end
    students.merge_by_index(@daily_report.students,:student_id) if @daily_report.students
    students
  end

  def text_list
    %w"text1 text2 text3 text4"
  end

  def homeworks
    @daily_report.homeworks = [
      {textbook: "text2", unit:"", page: "", due_date: "", students: [], memo: ""}
    ] unless @daily_report.homeworks
    @daily_report.homeworks
  end

  def contents
    @daily_report.contents = [
      {textbook: "text2", unit:"", page: "", due_date: "", students: [], memo: ""}
    ] unless @daily_report.contents
    @daily_report.contents
  end
end
