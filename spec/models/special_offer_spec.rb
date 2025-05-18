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
require 'rails_helper'

describe SpecialOffer, type: :model do

  subject(:special_offer) { create :special_offer }

  describe 'validations' do
    it { is_expected.to be_valid }
    it {is_expected.to belong_to :product}
    it {is_expected.to validate_presence_of :activated_on}
    it {is_expected.to validate_presence_of :discount}
    it {is_expected.to validate_presence_of :next_affected}
    it {is_expected.to validate_presence_of :product}
    it {is_expected.to validate_numericality_of(:activated_on).is_greater_than 0}
    it {is_expected.to validate_numericality_of(:next_affected).is_greater_than 0}
    it do
      is_expected.to validate_numericality_of(:discount)
          .is_greater_than(0)
          .is_less_than_or_equal_to 1
    end
  end   # validations

  describe 'before_save' do
    let(:existing_offer) {create :special_offer, active: true}
    let(:product) {existing_offer.product}

    it 'ensures that #product has maximum 1 active #special_offers' do
      expect do
        create :special_offer, active: true, product_code: product.code
      end.not_to change product.special_offers.active, :count
    end
  end

  describe 'class methods' do
    describe 'scopes' do
      describe '::ordered' do
        it 'orders the records of SpecialOffer by :product_code' do
          expect(described_class.ordered).to eq described_class
              .order(:product_code, :activated_on)
        end
      end

      describe '::active' do
        it 'returns only the records that have #active true' do
          expect(described_class.active).to eq described_class
              .where active: true
        end
      end
    end   # scopes
  end   # class methods

end
