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
      describe '.ordered' do
        it 'orders the records of DeliveryCost by :threshold' do
          expect(DeliveryCost.ordered).to eq DeliveryCost.order(:threshold)
        end
      end   # .ordered
    end   # scopes
  end   # class methods

end
