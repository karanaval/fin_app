require "test_helper"

class OperationTest < ActiveSupport::TestCase
  test "return false if amount is missed" do
    new_operation = Operation.new(odate: "2023-02-01",
      description: "New Description", category_id: Category.first.id)
    assert_not(new_operation.valid?)
  end

  test "return false if amount is less than 0" do
    new_operation = Operation.new(amount: -1.2, odate: "2023-02-01",
      description: "New Description", category_id: Category.first.id)
    assert_not(new_operation.valid?)
  end

  test "return false if odate is missed" do
    new_operation = Operation.new(amount: 30.5,
      description: "New Description", category_id: Category.first.id)
    assert_not(new_operation.valid?)
  end

  test "return false if description is missed" do
    new_operation = Operation.new(amount: 30.5,
      odate: "2023-02-01", category_id: Category.first.id)
    assert_not(new_operation.valid?)
  end

  def setup
     @new_operation = Operation.new(amount: 30.5, odate: "2023-02-01", description: "New Description")
  end

  test "return true if everything is ok" do
    new_operation = Operation.new(amount: 30.5, odate: "2023-02-01",
      description: "New Description", category_id: Category.first.id)
    assert(new_operation.valid?)
  end

  test "saving and gathering" do
    new_operation = Operation.new(amount: 30.5, odate: "2023-02-01",
      description: "New Description", category_id: Category.first.id)
    new_operation.save()
    new_op = Operation.find_by!(description: "New Description")
    assert_not_nil(new_op)
  end

end
