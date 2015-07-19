module Admin::StudentsHelper
  def schools
    @schools = [{school_id: "", note: ""}] unless @schools
  end
end
