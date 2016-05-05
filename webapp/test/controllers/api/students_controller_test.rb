require 'test_helper'

class Api::StudentsControllerTest < ActionController::TestCase
  include Devise::TestHelpers

  setup do
    DatabaseCleaner.clean
    @user = create(:user)
    @user.save!

    course = create(:course)
    course.save!
    student = create(:student)
    student.course_id = course.id
    student.save!
  end

  test "should not login" do
    get :index, format: "json"
    assert_response 401
  end

  test "should get index" do
    10.times do
      student = create(:sequence_students)
      student.save!
    end

    sign_in @user
    get :index, format: "json"
    assert_response :success

    json = JSON.parse(response.body)
    assert_equal(11, json.length)
    assert_equal("yamada taro", json[0]["fullname"])
    assert(json[0]["age"].is_a?(Integer))
    assert_equal("Aコース", json[0]["course"])
    assert_equal("鈴木 1郎", json[1]["fullname"])
    assert_equal("", json[1]["age"])
    sign_out @user
  end

end
