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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20131205075428) do

  create_table "authentications", :force => true do |t|
    t.integer  "user_id"
    t.string   "provider"
    t.string   "uid"
    t.string   "oauth_token"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.string   "token"
  end

  add_index "authentications", ["user_id"], :name => "index_authentications_on_user_id"

  create_table "categories", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "categories_foodbacks", :force => true do |t|
    t.integer "foodback_id"
    t.integer "category_id"
  end

  add_index "categories_foodbacks", ["category_id", "foodback_id"], :name => "index_categories_foodbacks_on_category_id_and_foodback_id"

  create_table "foodbacks", :force => true do |t|
    t.integer  "user_id"
    t.string   "title"
    t.text     "content"
    t.string   "cover"
    t.string   "invited_name"
    t.string   "invitedmail"
    t.datetime "date"
    t.integer  "city"
    t.string   "address"
    t.string   "dish"
    t.text     "recipe"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
    t.string   "cover_file_name"
    t.string   "cover_content_type"
    t.integer  "cover_file_size"
    t.datetime "cover_updated_at"
  end

  add_index "foodbacks", ["user_id", "city", "created_at"], :name => "index_foodbacks_on_user_id_and_city_and_created_at"

  create_table "invitations", :force => true do |t|
    t.integer  "invited_id"
    t.integer  "foodback_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "invitations", ["foodback_id"], :name => "index_invitations_on_foodback_id"
  add_index "invitations", ["invited_id"], :name => "index_invitations_on_invited_id"

  create_table "temporal_invitations", :force => true do |t|
    t.integer  "uid"
    t.integer  "foodback_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "temporal_invitations", ["uid"], :name => "index_temporal_invitations_on_uid"

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at",              :null => false
    t.datetime "updated_at",              :null => false
    t.integer  "uid",        :limit => 8
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true

end
