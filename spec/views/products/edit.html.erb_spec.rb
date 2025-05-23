require 'rails_helper'

describe "products/edit.html.erb", type: :view do
  let(:product) {create :product}

  before(:each) do
    assign(:product, product)
  end

  it "renders the edit product form" do
    render

    assert_select "form[action='#{product_path(product)}'][method='post']" do
      assert_select 'input#product_name[name=?]', 'product[name]'
      assert_select 'input#product_code[name=?]', 'product[code]'
      assert_select 'input#product_price[name=?]', 'product[price]'
    end
  end
end
