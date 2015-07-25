class Admin::SchoolsController < ApplicationController
  layout 'admin/dashboard'
  before_action :set_school, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  # GET /schools
  # GET /schools.json
  def index
    @schools = School.all
  end

  # GET /schools/1
  # GET /schools/1.json
  def show
  end

  # GET /schools/new
  def new
    @school = School.new
  end

  # GET /schools/1/edit
  def edit
  end

  # POST /schools
  # POST /schools.json
  def create
    @school = School.new(school_params)
    if @school.address[:prefecture] == "--都道府県--"
      @school.address[:prefecture] = ""
    end
    respond_to do |format|
      if @school.save
        format.html { redirect_to [:admin, @school], notice: 'School was successfully created.' }
        format.json { render :show, status: :created, location: [:admin, @school] }
      else
        format.html { render :new }
        format.json { render json: @school.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /schools/1
  # PATCH/PUT /schools/1.json
  def update
    param = school_params
    if param[:address][:prefecture] == "--都道府県--"
      param[:address][:prefecture] = ""
    end
    respond_to do |format|
      if @school.update(param)
        format.html { redirect_to [:admin, @school], notice: 'School was successfully updated.' }
        format.json { render :show, status: :ok, location: [:admin, @school] }
      else
        format.html { render :edit }
        format.json { render json: @school.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /schools/1
  # DELETE /schools/1.json
  def destroy
    @school.destroy
    respond_to do |format|
      format.html { redirect_to admin_schools_url, notice: 'School was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_school
      @school = School.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def school_params
      params.require(:school).permit(:name, :kind, :note,
        address: [:id, :post, :prefecture, :city, :address1, :address2])
    end

end
