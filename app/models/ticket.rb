class Ticket < ApplicationRecord
  belongs_to :account
  belongs_to :requester, class_name: "Contact", optional: true
  belongs_to :assignee, class_name: "User", optional: true
  has_many :messages, dependent: :destroy
  has_rich_text :description

  enum :status, { open: 0, pending: 1, resolved: 2, closed: 3 }
  enum :priority, { low: 0, normal: 1, high: 2, urgent: 3 }

  validates :subject, presence: true

  scope :recent, -> { order(created_at: :desc) }

  scope :with_status, ->(status) { where(status: status) if status.present? }
  scope :with_priority, ->(priority) { where(priority: priority) if priority.present? }
  scope :assigned_to, ->(assigned_id) {
    case assigned_id
    when "unassigned"
      where(assinged_id: nil)
    when nil, ""
      all
    else
      where(assigned_id: assigned_id)
    end
   }

   scope :search, ->(query) {
    return all if query.blank?

    term = "%#{sanitize_sql_like(query.strip)}%"

    left_joins(:requester)
      .where(
        <<~SQL.squish,
          tickets.subject ILIKE :term
          OR contacts.name ILIKE :term
          OR contacts.email ILIKE :term
        SQL
        term: term
      )
   }
end
