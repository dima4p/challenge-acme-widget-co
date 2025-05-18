class CreateProducts < ActiveRecord::Migration[8.0]
  def change
    create_table :products do |t|
      t.string :name
      t.string :code
      t.decimal :price, precision: 18, scale: 2

      t.timestamps
    end
  end
end
