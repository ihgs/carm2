class School
  include Mongoid::Document
  field :name, type: String
  field :kind, type: String
  field :note, type: String
  field :address, type: Hash

end
