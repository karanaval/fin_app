class ReportsController < ApplicationController
  def index
    @categories_options = Category.pluck(:name, :id)
  end

  # counting sum of operations' amounts by similar argument
  def count_amounts_per(arg)
    result = arg.inject({}) do |acc, op_per_cat|
      cat_name, amount = *op_per_cat
      acc[cat_name] =  acc[cat_name] ? acc[cat_name] += amount : amount
      acc
    end
  end

  # POST reports/report_by_category
  def report_by_category
    user_choice_category = params[:operation][:category_id]
    user_choice_date = params[:odate_from].values[0], params[:odate_to].values[0]
    date_from, date_to = *user_choice_date

    all_categories = user_choice_category == ""
    all_dates = user_choice_date == ["", ""]
    categories_data = Category.pluck(:id, :name).to_h

    if all_categories and all_dates then
      operations_data = Operation.op_data_all_cat(categories_data)
      operations_per_category_name = count_amounts_per(operations_data)
      @categories_names = operations_per_category_name.keys
      @amounts_per_categories = operations_per_category_name.values

    elsif all_categories and not all_dates
      operations_data = Operation.op_data_all_cat(date_from, date_to, categories_data)

      operations_per_category_id = count_amounts_per(operations_data)
      @categories_names = operations_per_category_id.keys
      @amounts_per_categories = operations_per_category_id.values

    elsif not all_categories and all_dates
      @categories_names = Category.where(id: user_choice_category.to_i).pluck(:name)
      @amounts_per_categories = [Operation.am_per_cat(user_choice_category)]

    else
      @categories_names = Category.where(id: user_choice_category.to_i).pluck(:name)
      @amounts_per_categories = [Operation.am_per_cat(date_from, date_to, user_choice_category)]
    end

    @category_name = all_categories ? "All categories" : Category.where(id: user_choice_category).pluck(:name).join()
    @dates_period = all_dates ? "for all period" : "from #{
      date_from.split("-").reverse.join("-")} to #{date_to.split("-").reverse.join("-")}"

  end

  # POST reports/report_by_dates
  def report_by_dates

    user_choice_category = params[:operation][:category_id]
    user_choice_date = *params[:odate_from].values, *params[:odate_to].values
    date_from, date_to = *user_choice_date

    all_categories = user_choice_category == ""
    all_dates = user_choice_date == ["", ""]

    operations_data = Operation.choose_option
    (
      date_from = date_from,
      date_to = date_to,
      user_choice_category = user_choice_category,
      all_categories = all_categories,
      all_dates = all_dates
      )

    operations_per_date = count_amounts_per(operations_data)

    @dates = operations_per_date.map { |data| data[0] }
    @amounts_per_dates = operations_per_date.map { |data| data[1] }
    @category_name = all_categories ? "All categories" : Category.where(id: user_choice_category).pluck(:name).join()
    @dates_period = all_dates ? "for all period" : "from #{
      date_from.split("-").reverse.join("-")} to #{user_choice_date[-1].split("-").reverse.join("-")}"

  end

  # POST
  def choose_report_type
    if params[:by_category]
      redirect_to reports_report_by_category_path(request.parameters)
    elsif params[:by_dates]
      redirect_to reports_report_by_dates_path(request.parameters)
    end
  end

end
