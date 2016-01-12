class AdminController < ApplicationController
  before_filter :authenticate_user!   
  
  def users
    @users = User.all
    @title = t('actions.listing') + " " + t('activerecord.models.users')
    @roles = [['Admin', 1], ['User', 2]]
    
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @users }
    end
  end
  
  def add_role
    user = User.find(params[:id])
    
    role = case params[:role]
      when '1' then :admin
      when '2' then :user
      else nil
    end
    
    user.add_role role
    
    respond_to do |format|
      format.html { redirect_to admin_users_url }
      format.json { head :no_content }
    end
  end

  def remove_role
    user = User.find(params[:id])

    user.remove_role :admin
    user.remove_role :user
    
    respond_to do |format|
      format.html { redirect_to admin_users_url }
      format.json { head :no_content }
    end
  end
  
end