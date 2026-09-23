class Agent::BaseController < ApplicationController
  layout "agent"
  before_action :require_agent_access!

  private

  def require_agent_access!
    return if Current.user&.can_access_agent_workspace?

    redirect_to root_path, alert: "You don't have access to the agent workspace"
  end
end
