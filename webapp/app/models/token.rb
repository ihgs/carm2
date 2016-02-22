class Token
  include Mongoid::Document
  field :token, type: String
  field :created_at, type: Time

  def to_s
    return "#{self.token}, created_at:#{self.created_at}"
  end
end
