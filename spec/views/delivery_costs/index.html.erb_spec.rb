require 'rails_helper'

describe "delivery_costs/index.html.erb", type: :view do
  let!(:delivery_cost) {create :delivery_cost}

  before(:each) do
    allow(controller).to receive(:params)
        .and_return(ActionController::Parameters.new({}))
    assign :delivery_costs, DeliveryCost.all
  end

  it "renders a list of delivery_costs" do
    render

    assert_select 'p.threshold', text: Regexp.new(delivery_cost.threshold.to_s), count: 1
    assert_select 'p.price', text: Regexp.new(delivery_cost.price.to_s), count: 1
  end

end
