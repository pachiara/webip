class VlanIpsController < ApplicationController
  before_action :authenticate_user!
  # GET /vlan_ips
  # GET /vlan_ips.json
  def index
    # legge vlan
    @vlan = Vlan.find(params[:vlan_id])
    # paginazione
    if params[:page].nil? && !session[:vlan_ips_page].nil? then
       params[:page] = session[:vlan_ips_page]
    end
    if params[:per_page].nil? && !session[:vlan_ips_per_page].nil?
      params[:per_page] = session[:vlan_ips_per_page]
    end
    # default 10 righe per pagina
    if params[:per_page].nil? || params[:per_page].to_s.strip.length == 0
      params[:per_page] = 10
    end
    # nuova ricerca riparto dalla prima pagina
    if params[:searched].to_s.strip.length > 0 && params[:searched] != session[:vlan_ips_searched]
      params[:page] = 1
    end
    # ricerca
    @vlan_ips = VlanIp.search(@vlan.id, params[:sel], params[:searched], params[:page], params[:per_page])
    # salva valori in sessione
    session[:vlan_ips_page] = params[:page]
    session[:vlan_ips_per_page] = params[:per_page]
    session[:vlan_ips_searched] = params[:searched]
    @title = t('actions.listing') + " " + t('activerecord.models.vlan_ip')
    @search_form_path = vlan_vlan_ips_path
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
      if @vlan_ip.update(vlan_ip_params)
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
    @vlan_ip.update(vlan_ip_id_params)

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
    if @email.nil?
      subject = 'Assegnazione IP'
      text = "Hostname: "+@vlan_ip.hostname+"\nNote: "+@vlan_ip.note+"\nIP: "+@vlan_ip.ip+
      "\nNetwork: "+@vlan.network+"\nNetmask: "+@vlan.netmask+"\nGateway: "+@vlan.gateway+"\nDNS: "+@vlan.dns
      @email = Email.new({:id => 1, :text => text, :subject => subject, :sender => "webip@lispa.it"})
    end
  end

  def send_email
    @email = Email.new(email_params)
    respond_to do |format|
      if @email.valid?
        Notifier.send_email(@email).deliver
        format.html { redirect_to(vlan_vlan_ips_url) }
        format.json { head :no_content }
      else
        format.html { render action: "email" }
        format.json { head :no_content }
      end
    end
  end

  # GET /vlan_ips/search_all
  def search_all
    # paginazione
    if params[:page].nil? && !session[:vlan_ips_all_page].nil? then
       params[:page] = session[:vlan_ips_all_page]
    end
    if params[:per_page].nil? && !session[:vlan_ips_all_per_page].nil?
      params[:per_page] = session[:vlan_ips_all_per_page]
    end
    # default 10 righe per pagina
    if params[:per_page].nil? || params[:per_page].to_s.strip.length == 0
      params[:per_page] = 10
    end
    # nuova ricerca riparto dalla prima pagina
    if params[:searched].to_s.strip.length > 0 && params[:searched] != session[:vlan_ips_all_searched]
      params[:page] = 1
    end
    # ricerca
    @vlan_ips = VlanIp.search_all(params[:sel], params[:searched], params[:page], params[:per_page])
    # salva valori in sessione
    session[:vlan_ips_all_page] = params[:page]
    session[:vlan_ips_all_per_page] = params[:per_page]
    session[:vlan_ips_all_searched] = params[:searched]

    @title = t('actions.search') + " Host"
    @search_form_path = vlan_ips_search_all_path

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @vlans }
    end
  end

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def vlan_ip_params
      params.require(:vlan_ip).permit(:hostname, :ip, :note, :status, :vlan_id)
    end
    def vlan_ip_id_params
      params.permit(:hostname, :ip, :note, :status, :vlan_id)
    end
    def email_params
      params.require(:email).permit(:id, :text, :recipient, :subject, :sender)
    end

end
