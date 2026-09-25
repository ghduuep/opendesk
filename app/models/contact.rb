class Contact < ApplicationRecord
  include Searchable

  searchable_by :name, :email

  belongs_to :account
  belongs_to :user

  has_many :tickets, foreign_key: :requester_id, dependent: :restrict_with_error

  normalizes :email, with: ->(email) { email.strip.downcase }

  validates :email, presence: true, uniqueness: { scope: :account_id }

  def display_name
    name.presence || email
  end
end
