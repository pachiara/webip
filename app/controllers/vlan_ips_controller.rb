class VlanIpsController < ApplicationController
  before_filter :authenticate_user! 
  # GET /vlan_ips
  # GET /vlan_ips.json
  def index
#    @vlan_ips = VlanIp.all
#    @vlan_ips = VlanIp.find(:all, :order => 'ip')
    @vlan = Vlan.find(params[:vlan_id])
    @vlan_ips = VlanIp.where(:vlan_id => params[:vlan_id]).order("id asc")
    @title = t('actions.listing') + " " + t('activerecord.models.vlan_ip')
    session[:email] = nil
    
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @vlan_ips }
    end
  end

  # GET /vlan_ips/1
  # GET /vlan_ips/1.json
  def show
    @vlan_ip = VlanIp.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @vlan_ip }
    end
  end

  # GET /vlan_ips/new
  # GET /vlan_ips/new.json
  def new
    @vlan_ip = VlanIp.new
    @title = t('actions.new') + " " + t('activerecord.models.vlan_ip')
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @vlan_ip }
    end
  end

  # GET /vlan_ips/1/edit
  def edit
    @vlan_ip = VlanIp.find(params[:id])
    @title = t('actions.edit') + " " + t('activerecord.models.vlan_ip')
  end

  # POST /vlan_ips
  # POST /vlan_ips.json
  def create
    @vlan_ip = VlanIp.new(params[:vlan_ip])
    @title = t('actions.new') + " " + t('activerecord.models.vlan_ip')
    respond_to do |format|
      if @vlan_ip.save
        format.html { redirect_to(vlan_vlan_ips_url) }
        format.json { render json: @vlan_ip, status: :created, location: @vlan_ip }
      else
        format.html { render action: "new" }
        format.json { render json: @vlan_ip.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /vlan_ips/1
  # PUT /vlan_ips/1.json
  def update
    @vlan_ip = VlanIp.find(params[:id])
    @title = t('actions.edit') + " " + t('activerecord.models.vlan_ip')
    
    respond_to do |format|
      if @vlan_ip.update_attributes(params[:vlan_ip])
        format.html { redirect_to(vlan_vlan_ips_url) }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @vlan_ip.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /vlan_ips/1
  # DELETE /vlan_ips/1.json
  def destroy
    @vlan_ip = VlanIp.find(params[:id])
    @vlan_ip.destroy

    respond_to do |format|
      format.html { redirect_to(vlan_vlan_ips_url) }
      format.json { head :no_content }
    end
  end
  
  # GET /vlans/1/vlan_ips/1/release
  # GET /vlans/1/vlan_ips/1/release.json
  def release
    @vlan_ip = VlanIp.find(params[:vlan_ip_id])
    @vlan_ip.release
    @vlan_ip.update_attributes(params[:vlan_ip])

    respond_to do |format|
      format.html { redirect_to(vlan_vlan_ips_url) }
      format.json { head :no_content }
    end
  end
  
  # GET /vlans/1/vlan_ips/1/report
  # GET /vlans/1/vlan_ips/1/report.json
  # GET /vlans/1/vlan_ips/1/report.pdf
  def report
    @vlan_ip = VlanIp.find(params[:vlan_ip_id])
    @vlan = Vlan.find(params[:vlan_id])
  end

  # GET /vlans/1/vlan_ips/1/email
  # GET /vlans/1/vlan_ips/1/email.json  
  def email
    @title = t('actions.email') + " " + t('activerecord.models.vlan_ip')
    @vlan_ip = VlanIp.find(params[:vlan_ip_id])
    @vlan = Vlan.find(params[:vlan_id])
    if session[:email].nil?
      subject = 'Assegnazione IP'
      text = "Hostname: "+@vlan_ip.hostname+"\nNote: "+@vlan_ip.note+"\nIP: "+@vlan_ip.ip+
      "\nNetwork: "+@vlan.network+"\nNetmask: "+@vlan.netmask+"\nGateway: "+@vlan.gateway+"\nDNS: "+@vlan.dns
      @email = Email.new({:id => 1, :text => text, :subject => subject, :sender => "webip@lispa.it"})
    else
      @email = session[:email] 
    end   
  end
  
  def send_email
    @email = Email.new(params[:email])

    respond_to do |format|
      if @email.valid?
        Notifier.send_email(@email).deliver
        session[:email] = nil
        format.html { redirect_to(vlan_vlan_ips_url) }
        format.json { head :no_content }
      else
        session[:email] = @email
        format.html { redirect_to(vlan_vlan_ip_email_url) }
        format.json { head :no_content }
      end
    end
  end
  
end
