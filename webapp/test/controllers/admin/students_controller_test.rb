require 'test_helper'

class Admin::StudentsControllerTest < ActionController::TestCase
  include Devise::TestHelpers

  setup do
    @student = create(:student)
  end

  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create students" do
    assert_difference('Student.count') do
      post :create, student: {name:{family_name:"tanaka", first_name: "jiro"}}
    end
    assert_redirected_to admin_student_path(assigns(:student))
  end

  test "should show students" do
    get :show, id: @student
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @student
    assert_response :success
  end

  test "should update students" do
    patch :update, id: @student, student: {name:{family_name:"tanaka", first_name: "saburo"}}
    new_student = Student.find(@student)
    assert_equal("saburo",new_student[:name][:first_name])
    assert_redirected_to admin_student_path(assigns(:student))

  end

  test "should destroy students" do
    assert_difference('Student.count', -1) do
      delete :destroy, id: @student
    end

    assert_redirected_to admin_students_path
  end
end
