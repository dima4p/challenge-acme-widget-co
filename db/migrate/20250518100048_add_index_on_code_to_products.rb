class AddIndexOnCodeToProducts < ActiveRecord::Migration[8.0]
  def change
    add_index :products, :code, unique: true
  end
end
