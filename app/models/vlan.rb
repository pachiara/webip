class Vlan < ActiveRecord::Base
  attr_accessible :description, :dns, :gateway, :host_max, :host_min, :hosts_num, :netmask, :network, :vlan_code
  
  attr_accessor :used, :free
  
  validates_presence_of :description, :host_max, :host_min, :hosts_num, :netmask, :network, :vlan_code
  validates_numericality_of :hosts_num, :vlan_code
  validates :vlan_code, :inclusion => 1..4094
  validates :vlan_code, :uniqueness => true
  validates :network, :uniqueness => true
  
  has_many :vlan_ips
  
  def set_network 
    ip = IPAddress network
    self.netmask = ip.netmask
    self.host_min = ip.first.address
    self.host_max = ip.last.address
    self.hosts_num = ip.hosts.size
  end
  
  def hosts_count
     self.used = self.vlan_ips.where('status' => true).count
     self.free = self.hosts_num - used
     return true
  end

  
end
