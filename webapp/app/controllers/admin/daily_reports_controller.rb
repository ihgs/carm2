class Admin::DailyReportsController < ApplicationController
  layout 'admin/dashboard'
  before_action :set_admin_daily_report, only: [:show, :edit, :update, :destroy]

  # GET /admin/daily_reports
  # GET /admin/daily_reports.json
  def index
    @daily_reports = DailyReport.all
  end

  # GET /admin/daily_reports/1
  # GET /admin/daily_reports/1.json
  def show
  end

  # GET /admin/daily_reports/new
  def new
    @daily_report = DailyReport.new
  end

  # GET /admin/daily_reports/1/edit
  def edit
  end

  # POST /admin/daily_reports
  # POST /admin/daily_reports.json
  def create
    @daily_report = DailyReport.new(admin_daily_report_params)

    respond_to do |format|
      if @daily_report.save
        format.html { redirect_to @daily_report, notice: 'Daily report was successfully created.' }
        format.json { render :show, status: :created, location: @daily_report }
      else
        format.html { render :new }
        format.json { render json: @daily_report.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/daily_reports/1
  # PATCH/PUT /admin/daily_reports/1.json
  def update
    respond_to do |format|
      if @daily_report.update(admin_daily_report_params)
        format.html { redirect_to @daily_report, notice: 'Daily report was successfully updated.' }
        format.json { render :show, status: :ok, location: @daily_report }
      else
        format.html { render :edit }
        format.json { render json: @daily_report.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/daily_reports/1
  # DELETE /admin/daily_reports/1.json
  def destroy
    @daily_report.destroy
    respond_to do |format|
      format.html { redirect_to admin_daily_reports_url, notice: 'Daily report was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_daily_report
      @daily_report = Admin::DailyReport.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def admin_daily_report_params
      params.require(:admin_daily_report).permit(:date, :grade, :subject, :students, :homework, :tests, :note, :other)
    end
end
