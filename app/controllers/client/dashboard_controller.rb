class Client::DashboardController < Client::BaseController
  def index
    @tickets = Current.user.contact.tickets.where(account: Current.account)

    @open_tickets_count = @tickets.open.count
    @pending_tickets_count = @tickets.pending.count
    @resolved_tickets_count = @tickets.resolved.count

    @recent_tickets = @tickets.recent.limit(5)
  end
end
