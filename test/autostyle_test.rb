require 'test_helper'

class AutostyleTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::Autostyle::VERSION
  end

  def test_render
    style = Autostyle[background: { color: :red, image: 'url(bg.png)', '' => :foo }]
    assert_equal 'background-color: red; background-image: url(bg.png); background: foo', style.render
  end

  def test_merge
    style = Autostyle[background: { color: :red }]
    style[:background].merge!(color: :blue)
    assert_equal 'background-color: blue', style.render
  end

  def test_never_nil
    style = Autostyle.new
    style[:background][:color] = :red
    assert_equal 'background-color: red', style.render
  end

  def test_to_s
    style = Autostyle[background: { color: :red }]
    assert_equal 'style="background-color: red"', "style=\"#{style}\""
  end
end
