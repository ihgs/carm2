require 'test_helper'

class StudentTest < ActiveSupport::TestCase

  setup do
    @student = create(:student)
    @student1 = create(:student)

  end

  test "age" do
    assert_equal 15, @student.age
  end

  test "fullname" do
    assert_equal "山田 太郎", @student.fullname
  end

  # test "school_list" do
  #   school_list = @student.school_list
  #
  #   assert_equal 1, school_list.length
  #   assert_equal "第一小学校", school_list[0][:name]
  # end
  #
  # test "filter_school" do
  #   school_list = @student.school_list
  #   students = Student.filter_school(school_list[0][:school_id])
  #
  #   assert_equal 2, students
  # end

end
