require 'rails_helper'

describe "delivery_costs/edit.html.erb", type: :view do
  let(:delivery_cost) {create :delivery_cost}

  before(:each) do
    assign(:delivery_cost, delivery_cost)
  end

  it "renders the edit delivery_cost form" do
    render

    assert_select "form[action='#{delivery_cost_path(delivery_cost)}'][method='post']" do
      assert_select 'input#delivery_cost_threshold[name=?]', 'delivery_cost[threshold]'
      assert_select 'input#delivery_cost_price[name=?]', 'delivery_cost[price]'
    end
  end
end
