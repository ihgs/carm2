require 'test_helper'

class TextbookTest < ActiveSupport::TestCase

  setup do
    @textbook = create(:textbook)
  end

  test "to_s" do
    assert_equal "中１ 楽しい数学", @textbook.to_s
  end

  test "subunits_to_s: pass normal unit" do
    unit = @textbook.units["0"]

    expect = "正の数と負の数\r\n正の数と負の数の加法\r\n正の数と負の数の減法"
    assert_equal expect, Textbook.subunits_to_s(unit)
  end

  test "subunits_to_s:pass unit with no subunits" do
    unit = @textbook.units["null"]

    assert_equal "", Textbook.subunits_to_s(unit)
  end

  test "subunits_to_s: pass null" do
    assert_equal "", Textbook.subunits_to_s(nil)
  end

  test "subunit_to_a" do
    target = "正の数と負の数\r\n正の数と負の数の加法\r\n正の数と負の数の減法"
    expect = ["正の数と負の数","正の数と負の数の加法","正の数と負の数の減法"]

    assert_equal expect, Textbook.subunits_to_a(target)
  end

  test "subunit_to_a: with black line" do
    target = "正の数と負の数\r\n\r\n正の数と負の数の加法\r\n正の数と負の数の減法"
    expect = ["正の数と負の数","正の数と負の数の加法","正の数と負の数の減法"]

    assert_equal expect, Textbook.subunits_to_a(target)
  end

  test "subunit_to_a: with nil" do
    target = nil
    expect = []

    assert_equal expect, Textbook.subunits_to_a(target)
  end
end
