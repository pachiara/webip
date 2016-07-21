class Vlan < ApplicationRecord
  resourcify
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

#Metodi di classe

  class << self
    def search(sel, searched, page, per_page)
      if sel.nil? then sel = '1' end
      case sel
        when '1'
          search_vlan_code(searched, page, per_page)
        when '2'
          search_description(searched, page, per_page)
        when '3'
          search_network(searched, page, per_page)
      end
    end

    def search_vlan_code(vlan_code, page, per_page)
      order('vlan_code asc').where('vlan_code LIKE ?', "%#{vlan_code}%").paginate(page: page, per_page: per_page)
    end

    def search_description(description, page, per_page)
      order('vlan_code asc').where('description LIKE ?', "%#{description}%").paginate(page: page, per_page: per_page)
    end

    def search_network(network, page, per_page)
      order('vlan_code asc').where('network LIKE ?', "%#{network}%").paginate(page: page, per_page: per_page)
    end
  end

end
