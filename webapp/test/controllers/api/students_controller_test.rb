require 'test_helper'

class Api::StudentsControllerTest < ActionController::TestCase
  include Devise::TestHelpers

  setup do
    DatabaseCleaner.clean
    @user = create(:user)
    @user.save!

    course = create(:course)
    course.save!
    @student = create(:student)
    @student.course_id = course.id
    @student.save!
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

  test "should get show" do
    sign_in @user
    json = show @student.id
    assert_equal("yamada taro", json["fullname"])
  end

  test "shoud create student" do
    sign_in @user
    student = {
      name: {
        family_name: "Family",
        first_name: "First"
      }
    }
    post :create, student: student, :format=> "json"
    assert_response :success
    json = JSON.parse(response.body)
    id = json["id"]

    json = show id
    assert_equal("Family First", json["fullname"])
  end

  test "shoud update student" do
    sign_in @user
    student = {
      name: {
        family_name: "Family",
        first_name: "First"
      }
    }
    post :create, student: student, :format=> "json"
    assert_response :success
    json = JSON.parse(response.body)
    id = json["id"]

    json = show id
    assert_equal("Family First", json["fullname"])

    student[:name][:first_name] = "First1"
    post :update, id: id, student: student, :format=>"json"

    json = show id
    assert_equal("Family First1", json["fullname"])
  end

  def show id
    get :show, id: id, :format => "json"
    assert_response :success
    json = JSON.parse(response.body)
  end
end
