module ApplicationHelper
  def ticket_status_classes(ticket)
    case ticket.status
    when "open"
      "bg-green-50 text-green-700"
    when "pending"
      "bg-yellow-50 text-yellow-700"
    when "resolved"
      "bg-blue-50 text-blue-700"
    when "closed"
      "bg-gray-100 text-gray-600"
    end
  end
end
