class Admin::BaseController < ApplicationController
  layout "admin"
  before_action :require_admin_access

  private

  def require_admin_access
    return if Current.user&.can_access_admin?

    redirect_to root_path, alert: "You don't have permission to access this area."
  end
end
