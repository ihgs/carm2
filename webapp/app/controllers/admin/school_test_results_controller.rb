class Admin::SchoolTestResultsController < ApplicationController

  # POST
  def create
    @school_test_result = SchoolTestResult.new(school_test_result_params)
    if @school_test_result.save
      redirect_to "/admin/school_tests/#{@school_test_result.school_test_id}"
    else
      @school_test = SchoolTest.find(params[:id])
      render "admin_school_test_path", @school_test
    end
  end

  def update
  end


  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def school_test_result_params
      params.require(:school_test_result).permit(:student_id, :school_test_id,
      results: [:subject, :score])
    end
end
