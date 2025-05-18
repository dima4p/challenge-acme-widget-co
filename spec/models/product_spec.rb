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
require 'rails_helper'

describe Product, type: :model do

  subject(:product) { create :product }

  describe 'validations' do
    it { is_expected.to be_valid }
    it {is_expected.to validate_presence_of :code}
    it {is_expected.to validate_presence_of :name}
    it {is_expected.to validate_presence_of :price}
    it {is_expected.to validate_uniqueness_of :code}
    it {is_expected.to validate_uniqueness_of :name}
    it {is_expected.to validate_numericality_of(:price).is_greater_than_or_equal_to 0}
    it do
      is_expected.to have_many(:special_offers)
          .with_primary_key(:code)
          .with_foreign_key(:product_code)
          .dependent(:destroy)
    end
  end   # validations

  describe 'class methods' do
    describe 'scopes' do
      describe '.ordered' do
        it 'orders the records of Product by :name' do
          expect(Product.ordered).to eq Product.order(:name)
        end
      end   # .ordered
    end   # scopes
  end   # class methods

end
