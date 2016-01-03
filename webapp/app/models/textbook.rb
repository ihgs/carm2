class Textbook
  include Mongoid::Document
  field :name, type: String
  field :subject, type: String
  field :grade, type: String
  field :units, type: Hash #{"0"=>{"unit":"", "subunits":[]},"1"=>{...}}

  def to_s
    "#{self.grade} #{self.name}"
  end


  class << self
    def subunits_to_s unit
      subunits = unit["subunits"]
      if subunits
        return subunits.join("\r\n")
      else
        return ""
      end
    end

    def subunits_to_a unit_str
      return [] unless unit_str

      subunits_array = unit_str.split(/\r?\n/)
      subunits_array.reject(&:blank?)
    end
  end
end
