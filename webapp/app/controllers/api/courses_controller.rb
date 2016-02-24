class Api::CoursesController < ApplicationController
  before_action :set_course, only: [:show, :update, :destroy]
  before_action :authenticate_user!
  def index
    @courses = Course.all
    respond_to do |format|
      format.json { render json: @courses}
    end
  end

  def show
    render json: @course
  end


  def create
    @course = Course.new(course_params)

    respond_to do |format|
      if @course.save
        format.json { render json: @course }
      else
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    param = course_params

    respond_to do |format|
      if @course.update(param)
        format.json { render json: @course }
      else
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @course.destroy
    respond_to do |format|
      format.json { head :no_content }
    end
  end

  private

    def set_course
      puts params
      @course = Course.find(params[:id])
    end

    def course_params
      params.require(:course).permit(:name)
    end
end
