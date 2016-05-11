class SmtpConfig
  include Mongoid::Document
  field :smtp, type: Hash # {address:, port:, user_name:, password:}
  field :subject, type: String
  field :body, type: String

  def self.get
    config = SmtpConfig.first()
    unless config
      config = SmtpConfig.new()
      config.subject = '打刻のお知らせ'
      config.body = '{{student_name}}さんが{{timestamp}}に打刻しました'
    end
    return config
  end
end
