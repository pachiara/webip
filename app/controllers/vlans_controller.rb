class VlansController < ApplicationController
  before_filter :authenticate_user! 
  # GET /vlans
  # GET /vlans.json
  def index
    @vlans = Vlan.order('vlan_code').page(params[:page]).per_page(19)
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
    @vlan = Vlan.new(params[:vlan])
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
      if @vlan.update_attributes(params[:vlan])
#        format.html { redirect_to @vlan, notice: 'Vlan was successfully created.' }
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
  
end
