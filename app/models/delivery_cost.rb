# == Schema Information
#
# Table name: delivery_costs
#
#  id         :integer          not null, primary key
#  price      :decimal(18, 2)
#  threshold  :decimal(18, 2)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class DeliveryCost < ApplicationRecord

  scope :ordered, -> { order(:threshold) }

  validates :threshold, :price, presence: true
  validates :threshold, uniqueness: true
  validates :price, :threshold, numericality: {greater_than_or_equal_to: 0}
end
