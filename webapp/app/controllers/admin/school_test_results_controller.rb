class Admin::SchoolTestResultsController < ApplicationController
  before_action :authenticate_user!

  # POST
  def create
    strm = school_test_result_params
    result = SchoolTestResult.and(:school_test_id => strm[:school_test_id], :student_id =>  strm[:student_id] )
    if result.size > 0
      @school_test_result = result.first
      if @school_test_result.update(strm)
        redirect_to "/admin/school_tests/#{@school_test_result.school_test_id}"
      else
        @school_test = SchoolTest.find(params[:id])
        render "admin_school_test_path", @school_test
      end
    else
      @school_test_result = SchoolTestResult.new(school_test_result_params)
      if @school_test_result.save
        redirect_to "/admin/school_tests/#{@school_test_result.school_test_id}"
      else
        @school_test = SchoolTest.find(params[:id])
        render "admin_school_test_path", @school_test
      end
    end
  end

  def update
  end


  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def school_test_result_params
      params.require(:school_test_result).permit(:student_id, :school_test_id, :results).tap do | whitelisted |
        whitelisted[:results] = params[:school_test_result][:results] if params[:school_test_result][:results].is_a?(Hash)
      end
    end
end
