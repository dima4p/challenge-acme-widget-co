class CreateSpecialOffers < ActiveRecord::Migration[8.0]
  def change
    create_table :special_offers do |t|
      t.string :product_code, null: false, index: true
      t.integer :activated_on
      t.integer :next_affected
      t.decimal :discount, precision: 5, scale: 4
      t.boolean :active, null: false, default: false

      t.timestamps
    end

    add_foreign_key "special_offers", "products",
        column: :product_code,
        primary_key: :code
  end
end
