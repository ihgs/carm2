class Student
  include Mongoid::Document

  field :name, type: Hash
  field :card_id, type: String
  field :birthday, type: Date
  field :schools, type: Array  # [{school_id:, note:}]

  def age
    return "" unless self.birthday
    birth = self.birthday.strftime("%Y%m%d").to_i
    today = Date.today.strftime("%Y%m%d").to_i
    return (today - birth)/10000
  end

  def schools
    @schools = [{school_id: "", note: ""}] unless @schools
  end
end
