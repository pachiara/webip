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

ActiveRecord::Schema.define(version: 20151113111847) do

  create_table "users", force: :cascade do |t|
    t.string   "email",                  limit: 255, default: "", null: false
    t.string   "encrypted_password",     limit: 255, default: "", null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,   default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "vlan_ips", force: :cascade do |t|
    t.integer  "vlan_id",    limit: 4
    t.string   "ip",         limit: 15
    t.string   "hostname",   limit: 16
    t.boolean  "status"
    t.text     "note",       limit: 65535
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  add_index "vlan_ips", ["vlan_id", "hostname"], name: "index_vlan_ips_on_vlan_id_and_hostname", using: :btree
  add_index "vlan_ips", ["vlan_id", "ip"], name: "index_vlan_ips_on_vlan_id_and_ip", unique: true, using: :btree

  create_table "vlans", force: :cascade do |t|
    t.integer  "vlan_code",   limit: 4
    t.string   "network",     limit: 18
    t.string   "netmask",     limit: 15
    t.string   "host_min",    limit: 15
    t.string   "host_max",    limit: 15
    t.integer  "hosts_num",   limit: 4
    t.string   "gateway",     limit: 15
    t.string   "dns",         limit: 15
    t.text     "description", limit: 65535
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  add_index "vlans", ["vlan_code"], name: "index_vlans_on_vlan_code", unique: true, using: :btree

end
