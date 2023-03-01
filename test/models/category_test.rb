require "test_helper"

class CategoryTest < ActiveSupport::TestCase
  test "return false if name is missed" do
    new_category = Category.new(description: "New description")
    assert_not(new_category.valid?)
  end

  test "return false if name isn't unique" do
    new_category = Category.create(name: "First Category", description: "First description")
    assert_raise { dublicate_category = Category.create!(name: "First Category", description: "Dublicate description") }
  end

  test "return false if description is missed" do
    new_category = Category.new(name: "New Category")
    assert_not(new_category.valid?)
  end

  test "return true if everything is ok" do
    new_category = Category.new(name: "New Category", description: "New description")
    assert(new_category.valid?)
  end

  test "saving and gathering" do
    new_category = Category.new(name: "New Category", description: "New description")
    new_category.save()
    new_cat = Category.find_by(name: "New Category")
    assert_equal("New description", new_cat.description)
  end
end
