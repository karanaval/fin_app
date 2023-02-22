require 'date'

class ReportsController < ApplicationController
  def index
  end

  def report_by_category

    categories_options = Category.all.map{ |cat| [cat.id, cat.name] }

    operations_data = Operation.all.map { |op| [op.category_id.to_s, op.amount] }.sort_by { |element| element[0] }

    operations_per_cat_id = operations_data.inject({}) do |acc, op_per_cat|
      cat_id, amount = *op_per_cat
      acc[cat_id] =  acc[cat_id] ? acc[cat_id] += amount : amount
      acc
    end

    operations_per_cat_name = []
    for i in (0...operations_per_cat_id.length) do
      key = categories_options[i][0]
      operations_per_cat_name.push([categories_options[i][1], operations_per_cat_id["#{key}"]])
    end

  @categories_ids = operations_per_cat_name.map { |data| data[0] }
  @amounts_per_categories = operations_per_cat_name.map { |data| data[1].round() }

  end

  def report_by_dates

    operations_data = Operation.all.map { |op| [op.odate.to_s, op.amount] }.sort_by { |element| element[0] }

    operations_per_date = operations_data.inject({}) do |acc, op_per_date|
        date, amount = *op_per_date
        acc[date] =  acc[date] ? acc[date] += amount : amount
        acc
      end

    @dates = operations_per_date.map { |data| data[0] }
    @amounts_per_dates = operations_per_date.map { |data| data[1] }

  end
end
