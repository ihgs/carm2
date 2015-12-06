class Admin::AttachedFilesController < ApplicationController
  layout 'admin/dashboard'

  # GET /admin/attached_files
  def index
    @attached_files = AttachedFile.all
  end
end
