class Operation < ApplicationRecord
  belongs_to :category

  validates :amount, presence: true, numericality: { grater_than: 0 }
  validates :odate, :description, presence: true

  paginates_per 5
end
