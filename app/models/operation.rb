class Operation < ApplicationRecord
  belongs_to :category

  validates :amount,
    presence: true,
    numericality: { greater_than: 0 }

  validates :odate, :description,
    presence: true

  paginates_per 10
end
