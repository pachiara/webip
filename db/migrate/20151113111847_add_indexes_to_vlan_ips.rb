class AddIndexesToVlanIps < ActiveRecord::Migration[5.1]
  def up
    add_index :vlan_ips, [:vlan_id, :hostname]
  end
  def down
    remove_index :vlan_ips, [:vlan_id, :hostname]
  end
end
