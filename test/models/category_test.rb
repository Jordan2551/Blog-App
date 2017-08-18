require 'test_helper'

class CategoryTest < ActiveSupport::TestCase

  # Called before every test method runs. Can be used
  # to set up fixture information.
  def setup
    @category = Category.new(name: 'sports')
  end

  test "category should be valid" do
    assert @category.valid?
  end

  test "name should be present" do
    @category.name = "sports" # -> pass
    #@category.name = " " # -> fail
    assert @category.valid?
  end

  test "name should be unique" do
    @category.save
    category2 = Category.new(name: "sports")
    assert_not category2.valid?
  end

  test "name should not be too long" do
    @category.name = "allllllllllllllllllllllllllllllllllll"
    assert_not @category.valid?
  end

  test "name should not be too short" do
    @category.name = "h"
    assert_not @category.valid?
  end

end