class CreateVlanIps < ActiveRecord::Migration[5.1]
  def change
    create_table :vlan_ips do |t|
      t.integer :vlan_id,     :limit => 4
      t.string :ip,           :limit => 15
      t.string :hostname,     :limit => 16
      t.boolean :status
      t.text :note

      t.timestamps
    end

    add_index :vlan_ips, [:vlan_id, :ip], :unique => true
  end
end
