class Operation < ApplicationRecord
  belongs_to :category

  validates :amount,
    presence: true,
    numericality: { greater_than: 0 }

  validates :odate, :description,
    presence: true

  paginates_per 10

  # Get Operation data for all categories
  def self.op_data_all_cat(*args)
    if args.length == 1 then
      categories_data = *args
      pluck(:category_id, :amount).map { |op| [categories_data[0][op[0]].to_s, op[1]] }
    else
      date_f, date_t, categories_data = *args
      where(odate: (date_f..date_t)).order(:category_id).pluck(
        :category_id, :amount).map { |op| [categories_data[op[0]].to_s, op[1]] }
    end
  end

  # Get Operation data for selected category
  def self.am_per_cat(*args)
    if args.length == 1 then
      user_choice_category = *args  
      where(category_id: user_choice_category[0].to_i).pluck(:amount).sum
    else
      date_f, date_t, user_choice_category = *args 
      where(category_id: user_choice_category.to_i, odate: (date_f..date_t)).pluck(:amount).sum
    end
  end

  # Choose odate&amount attributes from Operations model
  def self.get_sorted_dates_and_amounts
    order(:odate).pluck(:odate, :amount).map { |op| [op[0].to_s, op[1]] }
  end

  # Choose option for Operation parameters for report by dates
  def self.choose_option(date_f, date_t, category, all_c, all_d)
    if all_c and all_d  then
      get_sorted_dates_and_amounts

    elsif all_c and not all_d then
      where(odate: (date_f..date_t)).get_sorted_dates_and_amounts

    elsif not all_c and all_d  then
      where(category_id: category).get_sorted_dates_and_amounts

    else
      where(category_id: category, odate: (date_f..date_t)).get_sorted_dates_and_amounts
    end
  end

end
