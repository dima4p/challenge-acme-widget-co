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
FactoryBot.define do
  factory :delivery_cost do
    threshold { rand 0..100.5 }
    price { rand 0..50.5 }
  end
end
