require 'rails_helper'

describe "delivery_costs/show.html.erb", type: :view do
  let(:delivery_cost) {create :delivery_cost}

  before(:each) do
    assign :delivery_cost, delivery_cost
  end

  it "renders attributes in p" do
    render
    assert_select 'p.threshold', text: Regexp.new(delivery_cost.threshold.to_s)
    assert_select 'p.price', text: Regexp.new(delivery_cost.price.to_s)
  end
end
