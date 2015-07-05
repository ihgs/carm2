require 'network'
class Admin::CurriculumsController < ApplicationController
  layout 'admin/dashboard'
  def index
    @nodes = Network::nodes
    @edges = Network::edges
    @options ={groups: Network::groups}
  end
end
