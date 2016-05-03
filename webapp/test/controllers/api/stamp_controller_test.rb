require 'test_helper'

class Api::StampControllerTest < ActionController::TestCase

  setup do
    @student = create(:student)
    @student.save!
    @token = "1234567890"
    token = Token.new token: @token,
              created_at: Time.now
    token.save!
  end

  test "should post index" do
    @request.headers["HTTP_ACCESS_TOKEN"] = @token
    post :index, {time: Time.now.to_i,card_id: "aaaaa", device_name: "device1"}
    assert_response :success

    json = JSON.parse(response.body)
    assert_equal("success", json["status"])
    assert_equal("yamada taro", json["name"])
  end

  test "should post index error without student" do
    @request.headers["HTTP_ACCESS_TOKEN"] = @token
    post :index, {time: Time.now.to_i,card_id: "bbbb", device_name: "device1"}
    assert_response :success

    json = JSON.parse(response.body)
    assert_equal("error", json["status"])
    assert_equal("This card(bbbb) is not registered.", json["message"])
  end

  test "should post index error without token" do
    @request.headers["HTTP_ACCESS_TOKEN"] = "aaaaaa"
    post :index, {time: Time.now.to_i,card_id: "aaaaa", device_name: "device1"}
    assert_response :success

    json = JSON.parse(response.body)
    assert_equal("error", json["status"])
    assert_equal("This reader is not registered", json["message"])
  end

end
