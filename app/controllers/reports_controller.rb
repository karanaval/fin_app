class ReportsController < ApplicationController
  def index
    @categories_options = Category.all.map{ |cat| [cat.name, cat.id] }
  end

  def report_by_category

    user_choice_cat = params[:operation][:category_id]
    user_choice_date = *params[:odate_from].values, *params[:odate_to].values

    if user_choice_cat == "" and user_choice_date == ["", ""]  then

      categories_options = Category.pluck(:id, :name)
      operations_data = Operation.pluck(:category_id, :amount).map { |op| [op[0].to_s, op[1]] }.sort_by { |op| op[0] }

      operations_per_cat_id = operations_data.inject({}) do |acc, op_per_cat|
        cat_id, amount = *op_per_cat
        acc[cat_id] =  acc[cat_id] ? acc[cat_id] += amount : amount
        acc
      end

      operations_per_cat_name = []
      for i in (0...operations_per_cat_id.length) do

        key_id = categories_options[i][0]
        category_name = categories_options[i][1]
        category_amount = operations_per_cat_id["#{key_id}"]

        operations_per_cat_name.push([category_name, category_amount])
      end

      @categories_names = operations_per_cat_name.map { |data| data[0] }
      @amounts_per_categories = operations_per_cat_name.map { |data| data[1].round() }

    elsif user_choice_cat == "" and user_choice_date != ["", ""]

      categories_options = Category.pluck(:id, :name)
      operations_data = Operation.where(odate: (user_choice_date[0]..user_choice_date[1])
    ).pluck(:category_id, :amount).map { |op| [op[0].to_s, op[1]] }.sort_by { |op| op[0] }

      operations_per_cat_id = operations_data.inject({}) do |acc, op_per_cat|
        cat_id, amount = *op_per_cat
        acc[cat_id] =  acc[cat_id] ? acc[cat_id] += amount : amount
        acc
      end

      operations_per_cat_name = []
      for i in (0...operations_per_cat_id.length) do

        key_id = categories_options[i][0]
        category_name = categories_options[i][1]
        category_amount = operations_per_cat_id["#{key_id}"]

        operations_per_cat_name.push([category_name, category_amount])
      end

      @categories_names = operations_per_cat_name.map { |data| data[0] }
      @amounts_per_categories = operations_per_cat_name.map { |data| data[1].round() }

    elsif user_choice_cat != "" and user_choice_date == ["", ""]
      @categories_names = [Category.where(id: user_choice_cat.to_i).pluck(:name)]
      @amounts_per_categories = [Operation.where(category_id: user_choice_cat.to_i).pluck(:amount).sum]

    else
      @categories_names = [Category.where(id: user_choice_cat.to_i).pluck(:name)]
      @amounts_per_categories = [Operation.where(
        category_id: user_choice_cat.to_i, odate: (user_choice_date[0]..user_choice_date[1])).pluck(:amount).sum]
    end
  end


  def report_by_dates

    user_choice_cat = params[:operation][:category_id]
    user_choice_date = *params[:odate_from].values, *params[:odate_to].values

    if user_choice_cat == "" and user_choice_date == ["", ""]  then

      operations_data = Operation.all.map { |op| [op.odate.to_s, op.amount] }.sort_by { |element| element[0] }

    elsif user_choice_cat == "" and user_choice_date != ["", ""]  then

      operations_data = Operation.where(
        odate: (user_choice_date[0]..user_choice_date[1])
      ).pluck(:odate, :amount).map { |op| [op[0].to_s, op[1]] }.sort_by { |op| op[0] }

    elsif user_choice_cat != "" and user_choice_date == ["", ""]  then

      operations_data = Operation.where(category_id: user_choice_cat
      ).pluck(:odate, :amount).map { |op| [op[0].to_s, op[1]] }.sort_by { |op| op[0] }

    else

      operations_data = Operation.where(
        category_id: user_choice_cat, odate: (user_choice_date[0]..user_choice_date[1])
      ).pluck(:odate, :amount).map { |op| [op[0].to_s, op[1]] }.sort_by { |op| op[0] }

    end

    operations_per_date = operations_data.inject({}) do |acc, op_per_date|
      date, amount = *op_per_date
      acc[date] =  acc[date] ? acc[date] += amount : amount
      acc
    end

    @dates = operations_per_date.map { |data| data[0] }
    @amounts_per_dates = operations_per_date.map { |data| data[1] }

  end


  # def chose_report_type
  #   if params[:by_category]
  #     redirect_to "/reports/report_by_category"
  #   elsif params[:by_dates]
  #     report_by_dates
  #  end
  # end

end
