require 'set'

class Admin::StudentsController < ApplicationController
  layout 'admin/dashboard'

  before_action :set_student, only: [:show, :edit, :update, :destroy, :test_results]
  before_action :authenticate_user!

  # GET /admin/students
  # GET /admin/students.json
  def index
    @students = Student.all
  end

  # GET /admin/students/1
  # GET /admin/students/1.json
  def show
  end

  # GET /admin/students/new
  def new
    @student = Student.new
  end

  # GET /admin/students/1/edit
  def edit
  end

  # POST /admin/students
  # POST /admin/students.json
  def create
    @student = Student.new(student_params)

    respond_to do |format|
      if @student.save
        format.html { redirect_to [:admin, @student], notice: 'Student was successfully created.' }
        format.json { render :show, status: :created, location: @student }
      else
        format.html { render :new }
        format.json { render json: @student.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/students/1
  # PATCH/PUT /admin/students/1.json
  def update
    respond_to do |format|
      if @student.update(student_params)
        format.html { redirect_to [:admin, @student], notice: 'Student was successfully updated.' }
        format.json { render :show, status: :ok, location: @student }
      else
        format.html { render :edit }
        format.json { render json: @admin.errors, status: :unprocessable_entity }
      end
    end
  end

  def test_results
    school_test_results = SchoolTestResult.where(:student_id => @student.id.to_s )

    subjects = Set.new
    @school_test_map = {}
    school_test_results.each do |school_test_result|
      school_test = SchoolTest.find(school_test_result.school_test_id)
      @school_test_map[school_test] = school_test_result
      subjects.merge( school_test_result.results.keys)
    end
    @subjects = subjects
  end

  # DELETE /admin/students/1
  # DELETE /admin/students/1.json
  def destroy
    @student.destroy
    respond_to do |format|
      format.html { redirect_to admin_students_url, notice: 'Student was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_student
      @student = Student.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def student_params
      params.require(:student).permit(:birthday, :card_id, schools: [:note, :school_id, :enterance_year],
        name:[:first_name, :family_name, :first_name_kana, :family_name_kana],
        )
    end
end
