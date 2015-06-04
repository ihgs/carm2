class School
  include Mongoid::Document
  field :name, type: String
  field :kind, type: String
  field :note, type: String
  embeds_one :address
  accepts_nested_attributes_for :address
  validates_associated :address
end
