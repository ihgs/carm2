module Admin::StudentsHelper
  def schools
      @student.schools = [{school_id: "", note: "", enterance_year: ""}] unless @student.schools
      @student.schools
  end
end
