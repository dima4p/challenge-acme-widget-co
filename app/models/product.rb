# == Schema Information
#
# Table name: products
#
#  id         :integer          not null, primary key
#  code       :string
#  name       :string
#  price      :decimal(18, 2)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_products_on_code  (code) UNIQUE
#
class Product < ApplicationRecord

  scope :ordered, -> { order(:name) }

  has_many :special_offers, -> {ordered},
      foreign_key: :product_code,
      primary_key: :code,
      dependent: :destroy

  validates :code, :name, :price, presence: true
  validates :code, :name, uniqueness: true
  validates :price, numericality: {greater_than_or_equal_to: 0}

  def price_for(quantity)
    special_offer&.apply_to(quantity) || quantity * price
  end

  private

  def special_offer
    special_offers.active.first
  end
end
