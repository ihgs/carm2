class Api::SchoolTestsController < ApplicationController
  before_action :authenticate_user!
  
  def index
    school_tests = SchoolTest.all
    schools = School.all.map do |school|
      [school.id.to_s, school]
    end
    schoolMap = Hash[schools]
    school_tests = school_tests.map do |school_test|
      school = schoolMap[school_test.school_id]
      school_test['school'] = school if school
      school_test
    end
    render json: school_tests.to_json
  end

  def show
    school_test = SchoolTest.find(params[:id])
    school_test['school'] = School.find(school_test.school_id) if school_test.school_id
    results = SchoolTestResult.where(:school_test_id => school_test.id.to_s )
    students = Student.all.map do |student|
      student[:fullname] = student.fullname
      [student.id.to_s, student]
    end
    studentMap = Hash[students]
    if results
      school_test['results'] =[]
      results.each do |result|
        student = studentMap.delete(result[:student_id])
        result[:student] = student if student
        school_test['results'].push(result)
      end
      school_test['not_input_students'] = studentMap.values
    end
    render json: school_test.to_json
  end
end
