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
FactoryBot.define do
  factory :product do
    sequence(:name) {|n| "Name#{format '%03d', n}" }
    sequence(:code) {|n| "Code#{format '%03d', n}" }
    price { rand 0.5..100.5 }
  end
end
