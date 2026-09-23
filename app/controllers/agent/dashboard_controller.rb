class Agent::DashboardController < ApplicationController
  def index
    tickets = Current.account.tickets

    @assigned_to_me_count = tickets.where(assignee: Current.user).count
    @unassigned_count = tickets.where(assignee: nil).count
    @open_count = tickets.open.count
    @urgent_count = tickets.urgent.count

    @my_tickets = tickets.where(assignee: Current.user).where.not(status: %i[resolved closed]).includes(:requester).recent.limit(5)

    @unassigned_tickets = tickets.where(assignee: nil).where.not(status: %i[resolved closed]).includes(:requester).recent.limit(5)
  end
end
