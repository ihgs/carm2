require 'network'
class Admin::LearningLevelMapsController < ApplicationController
  layout 'admin/dashboard'
  before_action :set_learning_level_map, only: [:show, :update, :network]
  before_action :authenticate_user!

  # GET /learning_level_maps/1
  def show
    @student = Student.find(params[:id])
  end

# GET /learning_level_maps/1/network
  def network
    @student = Student.find(params[:id])
    @nodes, @edges = Network::graph_data @learning_level_map.learning_level
    @options ={}
  end

  # PUT /learning_level_maps/1
  # TODO implemente json response
  def update
    tag = params[:tag]
    level = params[:level]

    respond_to do |format|
      begin
        @learning_level_map.push(tag, level)
        @learning_level_map.save!
        format.html { redirect_to ({action: 'show',id: params[:id]}), notice: 'Yes!! Success' }
        format.json { render json: { tag: params[:tag], level: params[:level], status: :success} }
      rescue => e
        @student = Student.find(params[:id])
        flash.now[:error] = e.to_s
        format.html { render :action => :show ,id: params[:id] }
        format.json { render json: e.to_s , status: :unprocessable_entity }
      end
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
