class Contact < ApplicationRecord
  belongs_to :account

  has_many :tickets, foreign_key: :requester_id, dependent: :restrict_with_error

  normalizes :email, with: ->(email) { email.strip.downcase }

  validates :email, presence: true, uniqueness: { scope: :account_id }

  def display_name
    name.presence || email
  end
end
