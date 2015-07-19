class Student
  include Mongoid::Document

  field :name, type: Hash
  field :card_id, type: String
  field :birthday, type: Date
  field :schools, type: Array  # [{school_id:, note:}]

  before_save :check_school

  def age
    return "" unless self.birthday
    birth = self.birthday.strftime("%Y%m%d").to_i
    today = Date.today.strftime("%Y%m%d").to_i
    return (today - birth)/10000
  end

  def fullname
    "#{name[:family_name]} #{name[:first_name]}"
  end

  def school_list
    return [] unless self.schools

    self.schools.map do | school |
      begin
        school_object = School.find(school[:school_id])
        name = school_object.name
      rescue
        name = "Not Found"
      end

      {name: name, note: school[:note]}
    end

  end

  protected
  def check_school
    if self.schools
      self.schools = self.schools.select do |school|
        school[:school_id] and school[:note]
      end
    end
  end
end
