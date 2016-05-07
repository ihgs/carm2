class Api::SchoolsController < ApplicationController
  before_action :authenticate_user!
  def index
    schools = School.all
    respond_to do |format|
      format.json { render json: schools}
    end
  end
end
