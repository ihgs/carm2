require 'test_helper'

class ArrayTest < ActiveSupport::TestCase
  test "should merge" do
    first = [
      {
        id: 1,
        name: "first",
        age: 30
      },
      {
        id: 2,
        name: "second",
        age: 32
      },
      {
        id: 3,
        name: "third",
        age: 33
      }
      ]
      second = [
        {
          id: 2,
          name: "over_second",
          age: 25
        },
        {
          id: 4,
          name: "forth",
          age: 12
        }
      ]

      result = first.merge_by_index_to_s(second, :id)

      assert_equal "first", result[0][:name]
      assert_equal "over_second", result[1][:name]
      assert_equal "forth", result[3][:name]
  end

  test "should merge with other index" do
    first = [
      {
        id: 1,
        name: "first",
        age: 30
      },
      {
        id: 2,
        name: "second",
        age: 32
      },
      {
        id: 3,
        name: "third",
        age: 33
      }
      ]
      second = [
        {
          uid: 2,
          name: "over_second",
          age: 25
        },
        {
          uid: 4,
          name: "forth",
          age: 12
        }
      ]

      result = first.merge_by_index_to_s(second, :id, :uid)

      assert_equal "first", result[0][:name]
      assert_equal "over_second", result[1][:name]
      assert_equal "forth", result[3][:name]
  end
end
