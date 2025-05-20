class Basket
  attr_reader :state

  def initialize(state = {})
    @state = state
  end

  def add(product_code)
    if product = Product.find_by(code: product_code)
      state[product_code] ||= 0
      state[product_code] += 1
    end
  end

  def total
    DeliveryCost.add_to(
      state.map do |product_code, quantity|
        Product.find_by(code: product_code).price_for quantity
      end.reduce(:+)
    )&.floor 2
  end
end
