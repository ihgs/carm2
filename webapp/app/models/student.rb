class Student
  include Mongoid::Document

  field :name, type: Hash
  field :card_id, type: String
  field :birthday, type: Date
  field :schools, type: Array  # [{school_id:, enterance_year: note:}]
  field :contact_information, type: Hash # {mail:}
  field :course_id, type: String

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
        name = school_object.display_name
        kind = school_object.kind
      rescue
        name = "Not Found"
      end

      {school_id: school[:school_id], name: name, note: school[:note], enterance_year: school[:enterance_year], kind: kind}
    end
  end

  def mail
    return nil unless self.contact_information
    return self.contact_information.with_indifferent_access["mail"]
  end

  class << self

    def filter_school school_id
      Student.where(:schools=>{"$elemMatch":{"school_id"=>school_id}})
    end

    def fullname student_id
      return "" if !student_id or student_id.empty?

      student = Student.find(student_id)
      student == nil ? "" : student.fullname
    end

  end

  protected
  def check_school
    if self.schools
      self.schools = self.schools.select do |school|
        school[:school_id]
      end
    end
  end
end
