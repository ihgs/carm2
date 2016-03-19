class Api::StudentsController < ApplicationController
  before_action :authenticate_user!
  def index
    students = Student.all
    schools = School.all

    response = students.map do |student|
      if student.schools
        student.schools.each do | school |
          schools.each do |sc|
            if sc.id == school["school_id"]
              school["kind"] = sc.kind
              school["name"] = sc.name
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

end
