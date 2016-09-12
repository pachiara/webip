class ChangeVlanIpsHostName < ActiveRecord::Migration[5.0]
  def change
    change_column :vlan_ips, :hostname, :string, :limit => 50
  end
end
