require 'rails_helper'

describe "products/show.html.erb", type: :view do
  let(:product) {create :product}

  before(:each) do
    assign :product, product
  end

  it "renders attributes in p" do
    render
    assert_select 'p.name', text: Regexp.new(product.name.to_s)
    assert_select 'p.code', text: Regexp.new(product.code.to_s)
    assert_select 'p.price', text: Regexp.new(product.price.to_s)
  end
end
