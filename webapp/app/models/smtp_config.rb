class SmtpConfig
  include Mongoid::Document
  field :smtp, type: Hash # {address:, port:, user_name:, password:}
  field :subject, type: String
  field :body, type: String
  field :from, type: String

  def self.get
    config = SmtpConfig.first()
    unless config
      config = SmtpConfig.new()
    end
    config.subject = '打刻のお知らせ' unless config.subject
    config.body = '{{student_name}}さんが{{timestamp}}に打刻しました' unless config.body
    config.from = '"default from" <from@example.com>' unless config.from
    return config
  end
end
