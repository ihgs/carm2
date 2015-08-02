module Admin::SchoolTestsHelper
  def subjects
    @school_test.subjects = [
      {name: "", average: "", test_range: ""}
    ] unless @school_test.subjects
    @school_test.subjects
  end
end
