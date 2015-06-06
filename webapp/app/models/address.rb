class Address
  include Mongoid::Document
  field :post, type: String
  field :prefecture, type: String
  field :city, type: String
  field :address1, type: String
  field :address2, type: String
end
