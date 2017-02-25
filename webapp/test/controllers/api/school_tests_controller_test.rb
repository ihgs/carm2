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
    @school_test2 = create(:school_test, :one)
    @school_test2.save!
    @school_test3 = create(:school_test, :two)
    @school_test3.save!
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
      assert_equal 3, json.length
      assert_equal "中間テスト", json[0]["name"]
      assert_equal "school1", json[0]["school"]["name"]
  end

  test "should get list from to" do
      sign_in @user
      get :index, :from=>"2010-09-1", :to=>"2010-09-30", format: "json"
      assert_response :success
      json = JSON.parse(response.body)
      assert_equal 0, json.length

      get :index, :from=>"2010-09-01", format: "json"
      assert_response :success
      json = JSON.parse(response.body)
      assert_equal 3, json.length

      get :index, :from=>"2010-10-03", format: "json"
      assert_response :success
      json = JSON.parse(response.body)
      assert_equal 1, json.length

      get :index, :to=>"2010-10-02", format: "json"
      assert_response :success
      json = JSON.parse(response.body)
      assert_equal 2, json.length

      get :index, :from=>"2010-09-01", :to=>"2010-11-01", format: "json"
      assert_response :success
      json = JSON.parse(response.body)
      assert_equal 3, json.length

      get :index, :from=>"2010-09-01", :to=>"2010-10-01", format: "json"
      assert_response :success
      json = JSON.parse(response.body)
      assert_equal 1, json.length

      get :index, :from=>"2010-10-02", :to=>"2010-10-02", format: "json"
      assert_response :success
      json = JSON.parse(response.body)
      assert_equal 1, json.length
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
