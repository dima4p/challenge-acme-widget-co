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
FactoryBot.define do
  factory :special_offer do
    association :product, factory: :product
    sequence(:activated_on) {rand 1..4}
    sequence(:next_affected) {rand 1..4}
    discount { rand 0.001..1.0 }
    active { false }
  end
end
