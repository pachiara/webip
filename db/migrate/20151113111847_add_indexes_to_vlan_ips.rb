class AddIndexesToVlanIps < ActiveRecord::Migration
  def up
    add_index :vlan_ips, [:vlan_id, :hostname]
  end
  def down
    remove_index :vlan_ips, [:vlan_id, :hostname]
  end
end
