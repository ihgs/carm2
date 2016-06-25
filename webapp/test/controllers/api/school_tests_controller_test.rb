require 'test_helper'

class Api::SchoolTestsControllerTest < ActionController::TestCase
  include Devise::TestHelpers

  setup do
    DatabaseCleaner.clean
    @user = create(:user)
    @user.save!
    @student = create(:student)
    @student.save!
    @school1 = create(:school)
    @school1.save!
    @school_test = create(:school_test)
    @school_test.school_id = @school1.id
    @school_test.save!
  end

  test "should not login" do
    get :index, format: "json"
    assert_response 401
  end

  test "should get list" do
      sign_in @user

      get :index, format: "json"
      assert_response :success
      json = JSON.parse(response.body)
      assert_equal 1, json.length
      assert_equal "中間テスト", json[0]["name"]
      assert_equal "school1", json[0]["school"]["name"]
  end

  test "should get detail" do
      sign_in @user

      get :show, id: @school_test.id, format: "json"
      assert_response :success
      json = JSON.parse(response.body)
      assert_equal "中間テスト", json["name"]
  end

  ## NOT IMPLEMENTED
  # test "should create new school_test" do
  #   sign_in @user
  #
  #   get :index, format: "json"
  #   assert_response :success
  #   json = JSON.parse(response.body)
  #   assert_equal 1, json.length
  #
  #   post :create, school_test: {name: "SchoolX"}, :format=> "json"
  #   assert_response :success
  #
  #   get :index, format: "json"
  #   assert_response :success
  #   json = JSON.parse(response.body)
  #   assert_equal 2, json.length
  #   assert_equal "SchoolX", json[1]["name"]
  #
  # end
  #
  # test "should update school_test" do
  #   sign_in @user
  #   post :create, course: {name: "SchoolY"}, :format=> "json"
  #   assert_response :success
  #   json = JSON.parse(response.body)
  #
  #   id = json["id"]
  #   get :show, id: id, :format=>"json"
  #   assert_response :success
  #   json = JSON.parse(response.body)
  #   assert_equal("SchoolY", json["name"])
  #
  #   json[:start_date] = Date.parse("2010-11-01")
  #   post :update, id: id, course: json, :format=>"json"
  #   assert_response :success
  #
  #   get :show, id: id, :format=>"json"
  #   assert_response :success
  #   json = JSON.parse(response.body)
  #   assert_equal("SchoolY", json["name"])
  #   assert_equal(Date.parse("2010-11-01"), json["start_date"])
  # end

  # test "should delete course" do
  #   sign_in @user
  #
  #   get :index, format: "json"
  #   assert_response :success
  #   json = JSON.parse(response.body)
  #   assert_equal 1, json.length
  #
  #   delete :destroy, id: json["id"], :format=>"json"
  #   assert_response :success
  #
  #   get :index, format: "json"
  #   assert_response :success
  #   json = JSON.parse(response.body)
  #   assert_equal 0, json.length
  #
  # end
end
