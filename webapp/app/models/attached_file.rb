class AttachedFile
  include Mongoid::Document
  include Mongoid::Timestamps

  field :original_filename, type: String
  field :content_type, type: String
  field :description, type: String
  field :parent_dir, type: String
  field :status, type: String
  field :category, type: String
  field :size, type: Integer

  attr_accessor :tempfile, :raw_data

  after_create :upload_file
  before_destroy :delete_file


  def upload_file
    if self.tempfile
      self.raw_data = self.tempfile.read
    end
    fs_client = FileStorage::Client.new
    result = fs_client.upload(self.id, self.content_type, self.raw_data )
    self.status = "uploaded"
    self.save
  end

  def delete_file
    fs_client = FileStorage::Client.new
    fs_client.delete(self.id)
  end

  def data
    fs_client = FileStorage::Client.new
    fs_client.download(self.id)
  end

  def to_s
    return self.original_filename + " ("+self.size.to_s + ") "
  end

  def with_link
    return link_to(self.to_s, [:download, :admin, self] )
  end

  class << self
    def build data
      AttachedFile.new(
        original_filename: data.original_filename,
        content_type: data.content_type,
        tempfile: data.tempfile,
        size: data.size
      )
    end
  end


end
