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

ActiveRecord::Schema.define(:version => 20130507165823) do

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

  create_table "vlan_ips", :force => true do |t|
    t.integer  "vlan_id"
    t.string   "ip",         :limit => 15
    t.string   "hostname",   :limit => 16
    t.boolean  "status"
    t.text     "note"
    t.datetime "created_at",               :null => false
    t.datetime "updated_at",               :null => false
  end

  add_index "vlan_ips", ["vlan_id", "ip"], :name => "index_vlan_ips_on_vlan_id_and_ip", :unique => true

  create_table "vlans", :force => true do |t|
    t.integer  "vlan_code"
    t.string   "network",     :limit => 18
    t.string   "netmask",     :limit => 15
    t.string   "host_min",    :limit => 15
    t.string   "host_max",    :limit => 15
    t.integer  "hosts_num"
    t.string   "gateway",     :limit => 15
    t.string   "dns",         :limit => 15
    t.text     "description"
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
  end

  add_index "vlans", ["vlan_code"], :name => "index_vlans_on_vlan_code", :unique => true

end
