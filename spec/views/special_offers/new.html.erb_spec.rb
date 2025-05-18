require 'rails_helper'

describe "special_offers/new.html.erb", type: :view do
  let(:special_offer) {build :special_offer}

  before(:each) do
    assign(:special_offer, special_offer)
  end

  it "renders new special_offer form" do
    render

    assert_select "form[action='#{special_offers_path}'][method='post']" do
      assert_select 'input#special_offer_product_code[name=?]', 'special_offer[product_code]'
      assert_select 'input#special_offer_activated_on[name=?]', 'special_offer[activated_on]'
      assert_select 'input#special_offer_next_affected[name=?]', 'special_offer[next_affected]'
      assert_select 'input#special_offer_discount[name=?]', 'special_offer[discount]'
      assert_select 'input#special_offer_active[name=?]', 'special_offer[active]'
    end
  end
end
