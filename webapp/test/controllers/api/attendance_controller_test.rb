require 'test_helper'

class Api::AttendanceControllerTest < ActionController::TestCase

  setup do
    student = Student.new
    student.name = {}
    student.name[:family_name] = "yamada"
    student.name[:first_name] = "taro"
    student.card_id = "aaaaa"
    student.save()
  end

  test "should post index" do
    post :index, {time: Time.now.to_i,card_id: "aaaaa", device_name: "device1"}
    assert_response :success

    json = JSON.parse(response.body)
    assert_equal(json["status"], "success")
    assert_equal(json["name"], "yamada taro")
  end

  test "should post index error without student" do
    post :index, {time: Time.now.to_i,card_id: "bbbb", device_name: "device1"}
    assert_response :success

    json = JSON.parse(response.body)
    assert_equal(json["status"], "error")
    assert_equal(json["message"], "This card is not registered.")
  end

end
