# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20150106041103) do

  create_table "categories", force: true do |t|
    t.text     "name"
    t.text     "description"
    t.text     "createDate"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "order_details", force: true do |t|
    t.integer  "Quantity"
    t.integer  "Order_id"
    t.integer  "Product_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "order_details", ["Order_id"], name: "index_order_details_on_Order_id", using: :btree
  add_index "order_details", ["Product_id"], name: "index_order_details_on_Product_id", using: :btree

  create_table "orders", force: true do |t|
    t.datetime "orderdate"
    t.datetime "shipdate"
    t.text     "ShippingAddress"
    t.integer  "ShippingCost"
    t.text     "OrderStatus"
    t.text     "description"
    t.integer  "User_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "email"
    t.text     "phonenumber"
    t.text     "username"
  end

  add_index "orders", ["User_id"], name: "index_orders_on_User_id", using: :btree

  create_table "products", force: true do |t|
    t.text     "name"
    t.text     "price"
    t.text     "description"
    t.text     "unitCost"
    t.text     "urlImage"
    t.text     "createDate"
    t.integer  "category_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "urlLargeImage"
    t.boolean  "recommend"
  end

  add_index "products", ["category_id"], name: "index_products_on_category_id", using: :btree
  add_index "products", ["user_id"], name: "index_products_on_user_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "password_digest"
    t.boolean  "admin",           default: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree

end
