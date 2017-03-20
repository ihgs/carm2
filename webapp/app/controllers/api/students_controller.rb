class Api::StudentsController < ApplicationController
  before_action :authenticate_user!
  def index
    puts params
    if params[:scope] == 'all'
      students = Student.all
    else
      students = Student.where(:graduated.in => [nil, false])
    end
    schools = School.all

    response = students.map do |student|
      _student student, schools
    end
    respond_to do |format|
      format.json { render json: response}
    end
  end

  def show
    student = Student.find(params[:id])
    schools = School.all
    st = _student student, schools
    respond_to do |format|
      format.json { render json: st}
    end
  end

  def create
    student = Student.new(student_params)
    respond_to do |format|
      if student.save(student_params)
        format.json { render json: student}
      else
        foramt.json { render json: "{error}"} # TODO
      end
    end
  end

  def update
    student = Student.find(params[:id])
    respond_to do |format|
      if student.update(student_params)
        format.json { render json: student}
      else
        foramt.json { render json: "{error}"} # TODO
      end
    end
  end

private
  def _student student, schools
    grade_num = 100
    if student.schools
      student.schools.each do | school |
        schools.each do |sc|
          if sc.id.to_s == school["school_id"]
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
    if !student["course_id"].blank?
      student["course"] = Course.find(student["course_id"]).name
    end
    student["fullname"] = student.fullname
    student["age"] = student.age
    student["links"] = {
      "edit": "/admin/students/#{student.id}/edit",
      "timestamp": "/admin/stamp/#{student.id}",
      "learning_level": "/admin/learning_level_maps/#{student.id}",
      "test_result": "/admin/students/test_results/#{student.id}"
    }
    student
  end

  def calc_grade enterance_year, target_date
    grade = target_date.year - enterance_year.to_i
    if target_date.month >= 4
      grade = grade + 1
    end
    return grade
  end

  def student_params
    params.require(:student).permit(:birthday, :card_id, :course_id, :graduated, schools: [:note, :school_id, :enterance_year],
      name:[:first_name, :family_name, :first_name_kana, :family_name_kana], contact_information:[:mail],
      )
  end
end
