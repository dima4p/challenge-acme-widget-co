# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.0].define(version: 2025_05_18_103741) do
  create_table "delivery_costs", force: :cascade do |t|
    t.decimal "threshold", precision: 18, scale: 2
    t.decimal "price", precision: 18, scale: 2
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "products", force: :cascade do |t|
    t.string "name"
    t.string "code"
    t.decimal "price", precision: 18, scale: 2
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["code"], name: "index_products_on_code", unique: true
  end

  create_table "special_offers", force: :cascade do |t|
    t.string "product_code", null: false
    t.integer "activated_on"
    t.integer "next_affected"
    t.decimal "discount", precision: 5, scale: 4
    t.boolean "active", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["product_code"], name: "index_special_offers_on_product_code"
  end

  add_foreign_key "special_offers", "products", column: "product_code", primary_key: "code"
end
