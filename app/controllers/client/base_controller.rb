class Client::BaseController < ApplicationController
  layout "client"
  before_action :require_customer_access!

  private

  def require_customer_access!
    return if Current.user&.can_access_customer_portal?

    redirect_to root_path, alert: "You don't have access to this area."
  end
end
