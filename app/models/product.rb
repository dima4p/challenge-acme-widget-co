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
class Product < ApplicationRecord

  scope :ordered, -> { order(:name) }

  validates :code, :name, :price, presence: true
  validates :code, :name, uniqueness: true
  validates :price, numericality: {greater_than_or_equal_to: 0}
end
