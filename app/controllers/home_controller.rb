class HomeController < ApplicationController
  def index
    if Current.user.can_access_agent_workspace?
      redirect_to agent_tickets_path
    else
      render :index
    end
  end
end
