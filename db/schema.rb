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

ActiveRecord::Schema.define(version: 20180318091142) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "carts", id: :integer, default: -> { "nextval('\"Cart_id_seq\"'::regclass)" }, force: :cascade do |t|
    t.integer "product_id"
    t.integer "user_id"
  end

  create_table "categories", id: :integer, default: -> { "nextval('productcategories_categoryid_seq'::regclass)" }, force: :cascade do |t|
    t.string "name", limit: 50, null: false
  end

  create_table "orders", id: :integer, default: -> { "nextval('orders_orderid_seq'::regclass)" }, force: :cascade do |t|
    t.integer "orderuserid", null: false
    t.integer "orderproductid", null: false
    t.float "orderamount", null: false
    t.string "ordershipaddress", limit: 100, null: false
    t.string "ordercity", limit: 50, null: false
    t.string "orderphone", limit: 20, null: false
    t.float "ordershipping", null: false
    t.float "ordertax", null: false
    t.string "orderemail", limit: 100, null: false
    t.datetime "orderdate", default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.integer "ordershipped", limit: 2, default: 0, null: false
    t.string "ordertrackingnumber", limit: 80
  end

  create_table "products", id: :integer, default: -> { "nextval('products_productid_seq'::regclass)" }, force: :cascade do |t|
    t.string "productname", limit: 100, null: false
    t.float "productprice", null: false
    t.float "productweight", null: false
    t.text "productdesc", null: false
    t.string "productthumb", limit: 100, null: false
    t.string "productimage", limit: 100, null: false
    t.integer "category_id"
    t.float "productstock"
    t.string "productlocation", limit: 250
  end

  create_table "users", id: :integer, default: -> { "nextval('users_userid_seq'::regclass)" }, force: :cascade do |t|
    t.string "useremail", limit: 500
    t.string "userpassword", limit: 500
    t.string "userfirstname", limit: 50
    t.string "userlastname", limit: 50
    t.string "usercity", limit: 90
    t.integer "useremailverified", limit: 2, default: 0
    t.string "userverificationcode", limit: 20
    t.string "userphone", limit: 20
    t.string "useraddress", limit: 100
    t.string "email"
    t.string "encrypted_password", limit: 128
    t.string "confirmation_token", limit: 128
    t.string "remember_token", limit: 128
    t.boolean "admin", default: false
    t.integer "sign_in_count"
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.datetime "remember_created_at"
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.index ["email"], name: "index_users_on_email"
    t.index ["remember_token"], name: "index_users_on_remember_token"
  end

end
