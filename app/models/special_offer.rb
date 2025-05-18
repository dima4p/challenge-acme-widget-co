# == Schema Information
#
# Table name: special_offers
#
#  id            :integer          not null, primary key
#  activated_on  :integer
#  active        :boolean          default(FALSE), not null
#  discount      :decimal(5, 4)
#  next_affected :integer
#  product_code  :string           not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
# Indexes
#
#  index_special_offers_on_product_code  (product_code)
#
# Foreign Keys
#
#  product_code  (product_code => products.code)
#
class SpecialOffer < ApplicationRecord

  belongs_to :product, required: true, foreign_key: :product_code, primary_key: :code

  validates :product, :activated_on, :discount, :next_affected, presence: true
  validates :activated_on, :next_affected, numericality: {greater_than: 0}
  validates :discount, numericality: {greater_than: 0, less_than_or_equal_to: 1}

  scope :ordered, -> { order(:product_code, :activated_on) }
  scope :active, -> {where active: true}

end
