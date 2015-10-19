class ApplicationController < ActionController::Base
  protect_from_forgery
#  skip_before_filter :require_no_authentication, :only => [:new, :create, :cancel]
  before_filter :authenticate_user!, :only => :token
end
