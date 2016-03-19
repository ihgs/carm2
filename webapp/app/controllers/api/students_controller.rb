class Api::StudentsController < ApplicationController
  before_action :authenticate_user!
  def index
    students = Student.all
    schools = School.all
    grade_num = 100
    response = students.map do |student|
      if student.schools
        student.schools.each do | school |
          schools.each do |sc|
            if sc.id == school["school_id"]
              school["kind"] = sc.kind
              school["name"] = sc.name
              _grade = calc_grade(school["enterance_year"], Date.today)
              if _grade < grade_num
                grade_num = _grade
                student["current_school"] = {
                  "kind": sc.kind,
                  "name": sc.name,
                  "grade": grade_num
                }
              end
            end
          end
        end
      end
      student["fullname"] = student.fullname
      student
    end
    respond_to do |format|
      format.json { render json: response}
    end
  end

  def calc_grade enterance_year, target_date
    grade = target_date.year - enterance_year.to_i
    if target_date.month < 4
      grade = grade - 1
    end
    return grade
  end
end
