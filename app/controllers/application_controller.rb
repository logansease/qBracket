class ApplicationController < ActionController::Base
   # protect_from_forgery :except => [:fb_signin, :create_fb]

  before_filter :login_with_access_token
  before_filter :check_for_json_content_type

  #helper is only available in views, so include the helper in controller
  #by putting here, get it in all controllers
  include SessionsHelper
  include ApplicationHelper

  def admin_user
    if (!current_user or !current_user.admin?)
      deny_access
    end
  end

end
