class VlansController < ApplicationController
  before_action :authenticate_user!
  # GET /vlans
  # GET /vlans.json
  def index
    @edit   = helpers.set_edit(current_user)
    @manage = helpers.set_manage(current_user)
    # paginazione
    if params[:page].nil? && !session[:vlan_page].nil?
      params[:page] = session[:vlan_page]
    end
    if params[:per_page].nil? && !session[:vlan_per_page].nil?
      params[:per_page] = session[:vlan_per_page]
    end
    # default 10 righe per pagina
    if params[:per_page].nil? || params[:per_page].to_s.strip.length == 0
      params[:per_page] = 10
    end
    # nuova ricerca riparto dalla prima pagina
    if params[:searched].to_s.strip.length > 0 && params[:searched] != session[:vlan_searched]
      params[:page] = 1
    end
    # ricerca
    @vlans = Vlan.search(params[:sel], params[:searched], params[:page], params[:per_page])
    # salva valori in sessione
    session[:vlan_page] = params[:page]
    session[:vlan_per_page] = params[:per_page]
    session[:vlan_searched] = params[:searched]
    @title = t('actions.listing') + " " + t('activerecord.models.vlan')

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @vlans }
    end
  end

  # GET /vlans/1
  # GET /vlans/1.json
  def show
    @vlan = Vlan.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @vlan }
    end
  end

  # GET /vlans/new
  # GET /vlans/new.json
  def new
    @change = false
    @vlan = Vlan.new
    @title = t('actions.new') + " " + t('activerecord.models.vlan')
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @vlan }
    end
  end

  # GET /vlans/1/edit
  def edit
    @change = true
    @vlan = Vlan.find(params[:id])
    @title = t('actions.edit') + " " + t('activerecord.models.vlan')
  end

  # POST /vlans
  # POST /vlans.json
  def create
    @vlan = Vlan.new(vlan_params)
    @title = t('actions.new') + " " + t('activerecord.models.vlan')

    if params[:set_network] == 'set'
      set
      return
    end

    respond_to do |format|
      if @vlan.save
        VlanIp.set_ips(@vlan.network, @vlan.id)  # crea tutti gli ip della network
        format.html { redirect_to(vlans_url) }
        format.json { render json: @vlan, status: :created, location: @vlan }
      else
        format.html { render action: "new" }
        format.json { render json: @vlan.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /vlans/1
  # PUT /vlans/1.json
  def update
    @vlan = Vlan.find(params[:id])
    @title = t('actions.edit') + " " + t('activerecord.models.vlan')
    respond_to do |format|
      if @vlan.update(vlan_params)
        format.html { redirect_to(vlans_url) }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @vlan.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /vlans/1
  # DELETE /vlans/1.json
  def destroy
    @vlan = Vlan.find(params[:id])
    @vlan.destroy
    VlanIp.delete_ips(@vlan.vlan_ips)  # cancella tutti gli ip della network

    respond_to do |format|
      format.html { redirect_to vlans_url }
      format.json { head :no_content }
    end
  end

  # POST /vlans/set
  def set
    if !@vlan.vlan_code.nil? and !@vlan.network.empty?
      @vlan.set_network
    end

    respond_to do |format|
      format.html { render action: "edit" }
      format.json { render json: @vlan }
    end
  end

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def vlan_params
      params.require(:vlan).permit(:description, :dns, :gateway, :host_max, :host_min, :hosts_num, :netmask, :network, :vlan_code)
    end

end
