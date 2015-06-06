class Student
  include Mongoid::Document

  field :name, type: Hash
  field :birthday, type: Date


  def age
    return "" unless self.birthday
    birth = self.birthday.strftime("%Y%m%d").to_i
    today = Date.today.strftime("%Y%m%d").to_i
    return (today - birth)/10000
  end
end
