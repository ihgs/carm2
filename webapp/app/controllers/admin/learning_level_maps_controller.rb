require 'network'
class Admin::LearningLevelMapsController < ApplicationController
  layout 'admin/dashboard'
  before_action :set_learning_level_map, only: [:show, :update, :network]

  # GET /learning_level_maps/1
  def show
    @student = Student.find(params[:id])
  end

# GET /learning_level_maps/1/network
  def network
    @student = Student.find(params[:id])
    @nodes = Network::nodes @learning_level_map.learning_level
    @edges = Network::edges
    @options ={}
  end

  # PUT /learning_level_maps/1
  def update
    tag = params[:tag]
    level = params[:level]
    begin
      @learning_level_map.push(tag, level)
      @learning_level_map.save!
      redirect_to ({action: 'show',id: params[:id]}), notice: 'Yes!! Success'
    rescue => e
      @student = Student.find(params[:id])
      flash.now[:error] = e.to_s
      render :action => :show ,id: params[:id]
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_learning_level_map
      begin
        @learning_level_map = LearningLevelMap.find(params[:id])
      rescue
        @learning_level_map = LearningLevelMap.new
        @learning_level_map._id = params[:id]
        @learning_level_map.learning_level = {}
      end
    end
end
