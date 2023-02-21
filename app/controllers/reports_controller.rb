require 'date'

class ReportsController < ApplicationController
  def index
  end

  def report_by_category
  end

  def report_by_dates

    operations_data = Operation.all.map { |op| [op.odate.to_s, op.amount] }.sort_by { |element| element[0] }

    operations_per_date = operations_data.inject({}) do |acc, op_per_date|
        date, operations = *op_per_date
        acc[date] =  acc[date] ? acc[date] += operations : operations
        acc
      end

    @dates = operations_per_date.map { |data| data[0] }
    @amounts = operations_per_date.map { |data| data[1] }

  end
end
