require 'network'
class Admin::CurriculumsController < ApplicationController
  layout 'admin/dashboard'
  def index
    @nodes, @edges = Network::graph_data
    @options ={}
  end
end
