require 'test_helper'

class Admin::LearningLevelMapsControllerTest < ActionController::TestCase
  # include Devise::TestHelpers
  #
  # setup do
  #   @student = create(:student)
  #   @learning_level_map = LearningLevelMap.new
  #   @learning_level_map.id = @student.id
  #   @learning_level_map.learning_level = {}
  #   @learning_level_map.save
  #
  #   @student2 = build(:student)
  #   @student2[:name][:first_name] = "goro"
  #   @student2.save
  #
  #   @admin_user = create :user
  # end
  #
  # test "should get show" do
  #   sign_in @admin_user
  #
  #   get :show, id: @student.id
  #   assert_response :success
  # end
  #
  # test "should get show without level_map" do
  #   sign_in @admin_user
  #
  #   get :show, id: @student2.id
  #   assert_response :success
  # end
  #
  # test "should put update" do
  #   sign_in @admin_user
  #
  #   put :update, id: @student.id, tag: "tag1", level: 25
  #
  #   lvm = LearningLevelMap.find(@learning_level_map.id)
  #   assert_equal 25, lvm.learning_level["tag1"]
  # end
  #
  # test "should get network" do
  #   sign_in @admin_user
  #
  #   get :network, id: @student.id
  #   assert_response :success
  # end
end
