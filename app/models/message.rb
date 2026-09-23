class Message < ApplicationRecord
  belongs_to :ticket
  belongs_to :user, optional: true
  has_rich_text :body

  enum :kind, { reply: 0, note: 1 }

  validates :body, presence: true

  scope :chronological, -> { order(created_at: :asc) }
  scope :visible_to_customer, -> { where(kind: :reply) }
end
