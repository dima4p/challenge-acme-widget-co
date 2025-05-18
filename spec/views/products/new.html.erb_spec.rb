require 'rails_helper'

describe "products/new.html.erb", type: :view do
  let(:product) {build :product}

  before(:each) do
    assign(:product, product)
  end

  it "renders new product form" do
    render

    assert_select "form[action='#{products_path}'][method='post']" do
      assert_select 'input#product_name[name=?]', 'product[name]'
      assert_select 'input#product_code[name=?]', 'product[code]'
      assert_select 'input#product_price[name=?]', 'product[price]'
    end
  end
end
