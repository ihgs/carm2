class Admin::AttachedFilesController < ApplicationController
  layout 'admin/dashboard'
  before_action :authenticate_user!

  # GET /admin/attached_files
  def index
    @attached_files = AttachedFile.all
  end

  def download
    attached_file = AttachedFile.find(params[:id])
    send_data( attached_file.data,
      :filename => attached_file.original_filename,
      :type => attached_file.content_type,
      :size => attached_file.size)
  end

end
