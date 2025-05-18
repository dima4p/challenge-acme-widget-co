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
      describe '::ordered' do
        it 'orders the records of Product by :name' do
          expect(Product.ordered).to eq Product.order(:name)
        end
      end   # ::ordered
    end   # scopes
  end   # class methods

  describe '#price_for(quantity)' do
    subject(:price_for) {product.price_for quantity}
    let(:quantity) {rand 1..10}

    it 'calls #special_offer' do
      expect(product).to receive :special_offer
      price_for
    end

    context 'when #special_offer returns nil' do
      it 'returns #price multiplied by quantity' do
        is_expected.to eq product.price * quantity
      end
    end

    context 'when #special_offer is present' do
      let(:special_offer) do
        create :special_offer, product_code: product.code, active: true
      end

      before do
        allow(product).to receive(:special_offer).and_return special_offer
      end

      it 'sends #apply_to to #special_offer with quantity and returns the result' do
        expect(special_offer).to receive(:apply_to).with(quantity).and_return :price
        is_expected.to be :price
      end
    end
  end

  describe 'private' do
    describe '#special_offer' do
      subject {product.send :special_offer}

      context 'when #special_offers is empty' do
        it 'returns nil' do
          is_expected.to be nil
        end
      end

      context 'when #special_offers is present' do
        let!(:special_offer) do
          create :special_offer, product_code: product.code, active: active
        end

        context 'but there is no active one' do
          let(:active) {false}

          it 'returns nil' do
            is_expected.to be nil
          end
        end

        context 'but there is an active one' do
          let(:active) {true}

          it 'returns it' do
            is_expected.to eq special_offer
          end
        end
      end
    end
  end   # private
end
