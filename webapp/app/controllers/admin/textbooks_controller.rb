class Admin::TextbooksController < ApplicationController
  layout 'admin/dashboard'

  before_action :set_admin_textbook, only: [:show, :edit, :update, :destroy, :units]

  # GET /admin/textbooks
  # GET /admin/textbooks.json
  def index
    opt = params.permit(:name, :subject, :grade)
    @textbooks = Textbook.where(opt)
  end

  # GET /admin/textbooks/1
  # GET /admin/textbooks/1.json
  def show
  end

  # GET /admin/textbooks/new
  def new
    @textbook = Textbook.new
  end

  # GET /admin/textbooks/1/edit
  def edit
  end

  # POST /admin/textbooks
  # POST /admin/textbooks.json
  def create
    @textbook = Textbook.new(admin_textbook_params)
    respond_to do |format|
      if @textbook.save
        format.html { redirect_to [:admin, @textbook ], notice: 'Textbook was successfully created.' }
        format.json { render :show, status: :created, location: @textbook }
      else
        format.html { render :new }
        format.json { render json: @textbook.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/textbooks/1
  # PATCH/PUT /admin/textbooks/1.json
  def update
    respond_to do |format|
      if @textbook.update(admin_textbook_params)
        format.html { redirect_to [:admin, @textbook ], notice: 'Textbook was successfully updated.' }
        format.json { render :show, status: :ok, location: @textbook }
      else
        format.html { render :edit }
        format.json { render json: @textbook.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/textbooks/1
  # DELETE /admin/textbooks/1.json
  def destroy
    @textbook.destroy
    respond_to do |format|
      format.html { redirect_to [:admin, @textbook], notice: 'Textbook was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_textbook
      @textbook = Textbook.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def admin_textbook_params
      form_params = params.require(:textbook).permit(:name, :subject, :grade, units:[:unit])
    end
end
