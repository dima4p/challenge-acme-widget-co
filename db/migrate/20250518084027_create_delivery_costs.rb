class CreateDeliveryCosts < ActiveRecord::Migration[8.0]
  def change
    create_table :delivery_costs do |t|
      t.decimal :threshold, precision: 18, scale: 2
      t.decimal :price, precision: 18, scale: 2

      t.timestamps
    end
  end
end
