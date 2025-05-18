require 'rails_helper'

describe "special_offers/show.html.erb", type: :view do
  let(:special_offer) {create :special_offer}

  before(:each) do
    assign :special_offer, special_offer
  end

  it "renders attributes in dl>dd" do
    render
    # assert_select 'p.product', text: Regexp.new(special_offer.product.name)
    assert_select 'p.product_code', text: Regexp.new(special_offer.product_code.to_s)
    assert_select 'p.activated_on', text: Regexp.new(special_offer.activated_on.to_s)
    assert_select 'p.next_affected', text: Regexp.new(special_offer.next_affected.to_s)
    assert_select 'p.discount', text: Regexp.new(special_offer.discount.to_s)
    assert_select 'p.active', text: Regexp.new(special_offer.active.to_s)
  end
end
