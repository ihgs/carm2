require 'test_helper'

class Api::CoursesControllerTest < ActionController::TestCase
  include Devise::TestHelpers

  setup do
    DatabaseCleaner.clean
    @user = create(:user)
    @user.save!

    @course = create(:course)
    @course.save!
  end

  test "should not login" do
    get :index, format: "json"
    assert_response 401
  end

  test "should create new couse" do
    sign_in @user

    get :index, format: "json"
    assert_response :success
    json = JSON.parse(response.body)
    assert_equal 1, json.length
    assert_equal "Aコース", json[0]["name"]

    post :create, course: {name: "Bコース"}, :format=> "json"
    assert_response :success

    get :index, format: "json"
    assert_response :success
    json = JSON.parse(response.body)
    assert_equal 2, json.length
    assert_equal "Bコース", json[1]["name"]

  end

  test "should update course" do
    sign_in @user
    post :create, course: {name: "Cコース"}, :format=> "json"
    assert_response :success
    json = JSON.parse(response.body)

    id = json["id"]
    get :show, id: id, :format=>"json"
    assert_response :success
    json = JSON.parse(response.body)
    assert_equal("Cコース", json["name"])

    post :update, id: id, course: {name: "Dコース"}, :format=>"json"
    assert_response :success

    get :show, id: id, :format=>"json"
    assert_response :success
    json = JSON.parse(response.body)
    assert_equal("Dコース", json["name"])
  end

  test "should delete course" do
    sign_in @user

    delete :destroy, id: @course.id, :format=>"json"
    assert_response :success

    get :index, format: "json"
    assert_response :success
    json = JSON.parse(response.body)
    assert_equal 0, json.length

  end
end
