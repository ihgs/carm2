require 'test_helper'

class School_Test < ActiveSupport::TestCase

  setup do
    @school1 = create(:school)
  end

  test "display_name" do
    assert_equal "第一小学校", @school1.display_name
  end
end
