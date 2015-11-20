class VlanIp < ActiveRecord::Base
  attr_accessible :hostname, :ip, :note, :status, :vlan_id
  validates_presence_of :ip, :vlan_id
  
  before_update :update_vlan_ip
  
  belongs_to :vlan, :foreign_key => "vlan_id" 

  def update_vlan_ip
    if self.hostname.size > 0
      self.status = true
    end    
  end
  
  def release
    self.hostname = ""
    self.note = ""
    self.status = false
  end  

#Metodi di classe

  class << self  
    
    def set_ips(network, vlan_id)
      ip = IPAddress network
      ip.hosts.size.times do |i|
        vlan_ip = VlanIp.new     
        vlan_ip.vlan_id = vlan_id
        vlan_ip.ip = ip.hosts[i].address
        vlan_ip.status = false
        vlan_ip.hostname = ""
        vlan_ip.note = ""
        vlan_ip.save
      end 
    end
    
    def delete_ips(vlan_ips)
      vlan_ips.size.times do |i|
        vlan_ip = VlanIp.find(vlan_ips[i].id)
        vlan_ip.destroy
      end
    end
    
    def search(vlan_id, sel, searched, page, per_page)
      if sel.nil? then sel = '1' end
      case sel
        when '1'
          search_note(vlan_id, searched, page, per_page)
        when '2'
          search_hostname(vlan_id, searched, page, per_page)
        when '3'
          search_ip(vlan_id, searched, page, per_page)
      end  
    end
    
    def search_ip(vlan_id, ip, page, per_page)
      order('id asc, ip').where('vlan_id = ?  AND ip LIKE ?', "#{vlan_id}", "%#{ip}%").paginate(page: page, per_page: per_page)   
    end
    
    def search_hostname(vlan_id, hostname, page, per_page)
      order('id asc, ip').where('vlan_id = ?  AND hostname LIKE ?', "#{vlan_id}", "%#{hostname}%").paginate(page: page, per_page: per_page)   
    end
    
    def search_note(vlan_id, note, page, per_page)
      order('id asc, ip').where('vlan_id = ?  AND note LIKE ?', "#{vlan_id}", "%#{note}%").paginate(page: page, per_page: per_page)   
    end
    
  end
  
end
