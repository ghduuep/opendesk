class Admin::DashboardController < Admin::BaseController
  def index
    tickets = Current.account.tickets
    users = Current.account.users
    contacts = Current.account.contacts

    @open_count = tickets.open.count
    @pending_count = tickets.pending.count
    @unassigned_count = tickets.where(assignee_id: nil).count
    @urgent_count = tickets.urgent.count

    @ticket_counts = {
      open: tickets.open.count,
      pending: tickets.pending.count,
      resolved: tickets.resolved.count,
      closed: tickets.closed.count
    }

    @agents_count = users.agent.count
    @admins_count = users.admin.count
    @customers_count = users.customer.count
    @contacts_count = contacts.count

    @recent_tickets = tickets.includes(:requester, :assignee).recent.limit(5)
  end
end
