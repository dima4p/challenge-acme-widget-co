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
require 'rails_helper'

describe DeliveryCost, type: :model do

  subject(:delivery_cost) { create :delivery_cost }

  describe 'validations' do
    it { is_expected.to be_valid }
    it {is_expected.to validate_presence_of :price}
    it {is_expected.to validate_presence_of :threshold}
    it {is_expected.to validate_uniqueness_of :threshold}
    it {is_expected.to validate_numericality_of(:price).is_greater_than_or_equal_to 0}
    it {is_expected.to validate_numericality_of(:threshold).is_greater_than_or_equal_to 0}
  end   # validations

  describe 'class methods' do
    describe 'scopes' do
      describe '.::ordered' do
        it 'orders the records of DeliveryCost by :threshold' do
          expect(DeliveryCost.ordered).to eq DeliveryCost.order(:threshold)
        end
      end   # ::ordered
    end   # scopes

    describe '::add_to(amount)' do
      subject(:add_to) {described_class.add_to amount}
      let(:amount) {10}
      let(:ordered) {described_class.ordered}
      let(:applicable) {ordered.where "threshold < ?", amount}

      before do
        allow(described_class).to receive(:ordered).and_return ordered
        allow(ordered).to receive(:where).and_return applicable
      end

      it 'calls ::ordered' do
        expect(described_class).to receive(:ordered).and_return ordered
        add_to
      end

      it 'looks for instances where #threshold is less than amount' do
        expect(ordered).to receive(:where)
            .with("threshold < ?", amount)
            .and_call_original
        add_to
      end

      it 'takes the last one of the found instances' do
        expect(applicable).to receive(:last).and_call_original
        add_to
      end

      context 'when there is nothing found' do
        it 'returns amount' do
          is_expected.to eq amount
        end
      end

      context 'when an instances is found' do
        let!(:less) {create :delivery_cost, threshold: 0, price: 3}
        let!(:equal) {create :delivery_cost, threshold: amount, price: 2}
        let!(:greater) {create :delivery_cost, threshold: amount + 0.01, price: 1}

        it 'returns the sum of amount and #price of the found instance' do
          is_expected.to eq amount + less.price
        end
      end
    end
  end   # class methods
end
