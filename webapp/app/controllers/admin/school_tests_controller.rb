class Admin::SchoolTestsController < ApplicationController
  layout 'admin/dashboard'
  before_action :set_school_test, only: [:show, :edit, :update, :destroy]

  # GET /school_tests
  # GET /school_tests.json
  def index
    @school_tests = SchoolTest.all
  end

  # GET /school_tests/1
  # GET /school_tests/1.json
  def show
  end

  # GET /school_tests/new
  def new
    @school_test = SchoolTest.new
  end

  # GET /school_tests/1/edit
  def edit
  end

  # POST /school_tests
  # POST /school_tests.json
  def create
    @school_test = SchoolTest.new(school_test_params)
    respond_to do |format|
      if @school_test.save
        format.html { redirect_to [:admin, @school_test], notice: 'School test was successfully created.' }
        format.json { render :show, status: :created, location: [:admin, @school_test] }
      else
        format.html { render :new }
        format.json { render json: @school_test.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /school_tests/1
  # PATCH/PUT /school_tests/1.json
  def update
    respond_to do |format|
      if @school_test.update(school_test_params)
        format.html { redirect_to [:admin, @school_test], notice: 'School test was successfully updated.' }
        format.json { render :show, status: :ok, location: [:admin, @school_test] }
      else
        format.html { render :edit }
        format.json { render json: @school_test.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /school_tests/1
  # DELETE /school_tests/1.json
  def destroy
    @school_test.destroy
    respond_to do |format|
      format.html { redirect_to admin_school_tests_url, notice: 'School test was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_school_test
      @school_test = SchoolTest.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def school_test_params
      form_params = params.require(:school_test).permit(:name, :start_date, :end_date,
      subjects: [:name, :average, :test_range])

      array_subjects = form_params[:subjects].select { |k, v|
        v["name"]
      }.values
      form_params[:subjects] = array_subjects
      form_params
    end
end
