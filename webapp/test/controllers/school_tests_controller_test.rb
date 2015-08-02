require 'test_helper'

class SchoolTestsControllerTest < ActionController::TestCase
  setup do
    @school_test = school_tests(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:school_tests)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create school_test" do
    assert_difference('SchoolTest.count') do
      post :create, school_test: {  }
    end

    assert_redirected_to school_test_path(assigns(:school_test))
  end

  test "should show school_test" do
    get :show, id: @school_test
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @school_test
    assert_response :success
  end

  test "should update school_test" do
    patch :update, id: @school_test, school_test: {  }
    assert_redirected_to school_test_path(assigns(:school_test))
  end

  test "should destroy school_test" do
    assert_difference('SchoolTest.count', -1) do
      delete :destroy, id: @school_test
    end

    assert_redirected_to school_tests_path
  end
end
