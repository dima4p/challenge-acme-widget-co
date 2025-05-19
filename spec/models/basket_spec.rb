require 'rails_helper'

describe Basket, type: :model do

  subject(:basket) { described_class.new state }
  let(:state) {{}}

  describe '#add(product_code)' do
    subject(:add) {basket.add product_code}
    let(:product_code) {'code'}

    context 'when there is no Product with this code' do
      it 'returns nil' do
        is_expected.to be nil
      end
    end

    context 'when there is a Product with this code' do
      let!(:product) {create :product, code: product_code}

      context 'and this product is not placed in the Basket' do
        it 'adds a new key product_code to #state' do
          expect{add}.to change(state, :keys).to [product_code]
        end

        it 'assigns value 1 to #state under this key' do
          add
          expect(state[product_code]).to be 1
        end

        it 'returns 1' do
          is_expected.to be 1
        end
      end

      context 'and this product is already placed in the Basket' do
        let(:state) {{product_code => previous_value}}
        let(:previous_value) {rand 1..5}

        it 'increments #state[product_code] by 1' do
          add
          expect(state[product_code]).to be previous_value + 1
        end

        it 'returns the new value' do
          is_expected.to be previous_value + 1
        end
      end
    end
  end

  describe '#total' do
    subject(:total) {basket.total}
    let(:product) {create :product}
    let(:product_code) {product.code}
    let(:amount) {rand 1..5}
    let(:state) {{product_code => amount}}

    before do
      allow(Product).to receive(:find_by).and_call_original
      allow(Product).to receive(:find_by).with(code: product_code).and_return product
    end

    describe 'for each key in #state' do
      it 'finds the corresponding Product by this key' do
        expect(Product).to receive(:find_by)
            .with(code: product_code)
            .and_return product
        total
      end

      it 'sends :price_for to the found Product with the value corresponding to the key in #state' do
        allow(product).to receive(:price_for).with(amount).and_call_original
        total
      end
    end

    describe 'after processing each entry of #state' do
      it 'calculates the sum of all calls to Product#price_for and sends :add_to to DeliveryCost with this sum' do
        expect(DeliveryCost).to receive(:add_to).with product.price * amount
        total
      end

      it 'returns the result of the call DeliveryCost::add_to rounded to 2 digits after the dot' do
        allow(DeliveryCost).to receive(:add_to).and_return 56.125
        is_expected.to eq 56.12
      end
    end

    describe 'example baskets and expected totals' do
      let!(:rw) {create :product, code: 'R01', price: 32.95}
      let!(:gw) {create :product, code: 'G01', price: 24.95}
      let!(:bw) {create :product, code: 'B01', price: 7.95}
      let!(:dc1) {create :delivery_cost, price: 4.95, threshold: 0}
      let!(:dc2) {create :delivery_cost, price: 2.95, threshold: 50}
      let!(:dc3) {create :delivery_cost, price: 0, threshold: 90}
      let!(:so) do
        create :special_offer,
            activated_on: 1,
            active: true,
            discount: 0.5,
            next_affected: 1,
            product: rw
      end

      context 'case [B01, G01]' do
        let(:state) {{'B01' => 1, 'G01' => 1}}
        it 'gives $37.85' do
          is_expected.to eq 37.85
        end
      end

      context 'case [R01, R01]' do
        let(:state) {{'R01' => 2}}
        it 'gives $54.37' do
          is_expected.to eq 54.37
        end
      end

      context 'case [R01, G01]' do
        let(:state) {{'R01' => 1, 'G01' => 1}}
        it 'gives $60.85' do
          is_expected.to eq 60.85
        end
      end

      context 'case [B01, B01, R01, R01, R01]' do
        let(:state) {{'B01' => 2, 'R01' => 3}}
        it 'gives $98.27' do
          is_expected.to eq 98.27
        end
      end
    end
  end
end
