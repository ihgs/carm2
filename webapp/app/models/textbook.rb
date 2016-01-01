class Textbook
  include Mongoid::Document
  field :name, type: String
  field :subject, type: String
  field :grade, type: String
  field :units, type: Hash

  def to_s
    "#{self.grade} #{self.name}"
  end
end
