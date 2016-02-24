class Admin::SettingsController < ApplicationController
  layout 'admin/dashboard'
  before_action :authenticate_user!
  def index

  end

end
