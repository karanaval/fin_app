class Operation < ApplicationRecord
  belongs_to :category

  validates :amount,
    presence: true,
    numericality: { greater_than: 0 }

  validates :odate, :description,
    presence: true

  paginates_per 10

  # Choose Operation options for all categories
  def self.op_data_all_dat(params)
    pluck(:category_id, :amount).map { |op| [params[op[0]].to_s, op[1]] }
  end

  def self.op_data_not_all_dat(date_f, date_t, params)
    where(odate: (date_f..date_t)).order(:category_id).pluck(
        :category_id, :amount).map { |op| [params[op[0]].to_s, op[1]] }
  end

  # Choose Operation options for not all categories
  def self.am_per_cat_all_dat(params)    
      where(category_id: params.to_i).pluck(:amount).sum
  end

  def self.am_per_cat_not_all_dat(date_f, date_t, params)    
      where(category_id: params.to_i, odate: (date_f..date_t)).pluck(:amount).sum
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
