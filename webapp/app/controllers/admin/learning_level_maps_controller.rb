class Admin::LearningLevelMapsController < ApplicationController
  layout 'admin/dashboard'
  before_action :set_learning_level_map, only: [:show, :update]

  # GET /learning_level_maps/1
  def show
    @student = Student.find(params[:id])
  end

  # PUT /learning_level_maps/1
  def update
    tag = params[:tag]
    level = params[:level]
    @learning_level_map.push(tag, level)
    @learning_level_map.save!
    redirect_to ({action: 'show',id: params[:id]}), notice: 'Yes!! Success'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_learning_level_map
      begin
        @learning_level_map = LearningLevelMap.find(params[:id])
      rescue
        @learning_level_map = LearningLevelMap.new
        @learning_level_map._id = params[:id]
      end
    end
end
