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

ActiveRecord::Schema.define(:version => 20141126165902) do

  create_table "backgrounds", :force => true do |t|
    t.string   "url"
    t.boolean  "is_primary"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "domains", :force => true do |t|
    t.integer  "site_id"
    t.string   "domain"
    t.boolean  "is_primary", :default => false
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
  end

  add_index "domains", ["site_id"], :name => "index_domains_on_site_id"

  create_table "photos", :force => true do |t|
    t.string   "photo_file_name"
    t.string   "photoable_type"
    t.integer  "photoable_id"
    t.boolean  "is_primary",      :default => false
    t.datetime "created_at",                         :null => false
    t.datetime "updated_at",                         :null => false
  end

  add_index "photos", ["photoable_id", "photoable_type"], :name => "index_photos_on_photoable_id_and_photoable_type"

  create_table "sites", :force => true do |t|
    t.string   "name"
    t.boolean  "is_default", :default => false
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
  end

end
