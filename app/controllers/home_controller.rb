class HomeController < ApplicationController
  def index
    @user = User.new
    @title = t('title')
    respond_to do |format|
      if user_signed_in?
        format.html { redirect_to(vlans_url) }
        format.xml  { render json: @user }
      else
        format.html # index.html.erb
        format.json { render json: @user }
      end
    end
  end
end
