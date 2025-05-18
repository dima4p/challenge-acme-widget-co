require 'rails_helper'

describe "products/index.html.erb", type: :view do
  let!(:product) {create :product}

  before(:each) do
    allow(controller).to receive(:params)
        .and_return(ActionController::Parameters.new({}))
    assign :products, Product.all
  end

  it "renders a list of products" do
    render

    assert_select 'p.name', text: Regexp.new(product.name.to_s), count: 1
    assert_select 'p.code', text: Regexp.new(product.code.to_s), count: 1
    assert_select 'p.price', text: Regexp.new(product.price.to_s), count: 1
  end
end
