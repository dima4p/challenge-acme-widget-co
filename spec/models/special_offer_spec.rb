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

  describe '#apply_to(quantity)' do
    subject(:apply_to) {special_offer.apply_to quantity}
    let(:quantity) {rand 1..50}
    let(:step) {special_offer.send :step}
    let(:number_of_steps) {quantity / step}

    before do
      allow(special_offer).to receive(:coefficient)
          .and_call_original
    end

    it 'calls #coefficient without arguments' do
      expect(special_offer).to receive(:coefficient)
          .with(no_args).and_call_original
      apply_to
    end

    context 'when quantity is less then #step' do
      let(:quantity) {rand 1..(step - 1)}
      let(:step) {special_offer.send :step}

      it 'calls #coefficient with quantity' do
        expect(special_offer).to receive(:coefficient)
            .with(quantity)
            .and_call_original
        apply_to
      end
    end

    context 'when quantity is a multiple of #step' do
      let(:quantity) {rand(1..5) * step}

      it 'calls #coefficient with 0' do
        expect(special_offer).to receive(:coefficient)
            .with(0)
            .and_call_original
        apply_to
      end
    end

    context 'after these calls' do
      before do
        allow(special_offer).to receive(:coefficient)
            .with(no_args).and_return 1
        allow(special_offer).to receive(:coefficient)
            .with(any_args).and_return 10
        allow(special_offer).to receive(:price).and_return 1
      end

      it 'returns #price multiplied by the sum of the result of the call #coefficient with argument and the result of the call #coefficient without argument where the last is multiplied by integer division of quantity by #step' do
        is_expected.to eq special_offer.price * (10 * number_of_steps + 10)
      end
    end
  end   # apply_to(quantity)

  describe '#price' do
    subject(:price) {special_offer.price}
    let(:product) {special_offer.product}

    it 'returns #price of the #product' do
      is_expected.to be product.price
    end
  end

  describe 'private' do
    describe '#coefficient(quantity = step)' do
      subject(:coefficient) {special_offer.send :coefficient, quantity}
      let(:special_offer) do
        create :special_offer,
            activated_on: activated_on,
            next_affected: next_affected
      end
      let(:activated_on) {rand 2..4}
      let(:next_affected) {rand 2..4}

      context 'when quantity is less than #activated_on' do
        let(:quantity) {rand 1..(activated_on - 1)}

        it 'returns quantity' do
          is_expected.to be quantity
        end
      end

      context 'when quantity equals to #activated_on' do
        let(:quantity) {activated_on}

        it 'returns quantity' do
          is_expected.to be quantity
        end
      end

      context 'when quantity is greater than #activated_on' do
        let(:quantity) {activated_on + rand(1..(next_affected))}

        it 'returns #activated_on plus (#quantity - #activated_on) multiplied by 1 - #discount' do
          is_expected.to eq activated_on +
              (quantity - activated_on) * (1 - special_offer.discount)
        end
      end
    end

    describe '#step' do
      subject(:step) {special_offer.send :step}

      it 'returns #activated_on + #next_affected' do
        is_expected.to be special_offer.activated_on + special_offer.next_affected
      end
    end
  end   # private
end
