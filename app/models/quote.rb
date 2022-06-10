class Quote < ApplicationRecord
  validates :name, presence: true

  scope :ordered, -> { order(created_at: :desc) }
  belongs_to :company
  has_many :line_item_dates, dependent: :destroy
  has_many :line_items, through: :line_item_dates

  broadcasts_to -> (quote) { [quote.company, "quotes"] }, inserts_by: :prepend

  def total_price
    line_items.sum(&:total_price)
  end
end
