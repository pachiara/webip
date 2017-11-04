class CreateVlans < ActiveRecord::Migration[5.0]
  def change
    create_table :vlans do |t|
      t.integer :vlan_code,    :limit => 4
      t.string :network,       :limit => 18
      t.string :netmask,       :limit => 15
      t.string :host_min,      :limit => 15
      t.string :host_max,      :limit => 15
      t.integer :hosts_num,    :limit => 10
      t.string :gateway,       :limit => 15
      t.string :dns,           :limit => 15
      t.text :description

      t.timestamps
    end

    add_index :vlans, :vlan_code, :unique => true
  end
end
