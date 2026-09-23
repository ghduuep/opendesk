class HomeController < ApplicationController
  def index
    if Current.user&.can_access_agent_workspace?
      redirect_to agent_tickets_path
    elsif Current.user&.can_access_customer_portal?
      redirect_to client_root_path
    end
  end
end
