class User < ApplicationRecord
  belongs_to :account

  has_secure_password
  has_many :sessions, dependent: :destroy
  has_many :assigned_tickets, class_name: "Ticket", foreign_key: :assignee_id, dependent: :nullify
  has_one :contact, dependent: :nullify

  enum :role, { customer: 0, agent: 1, admin: 2 }

  validates :email_address, presence: true, uniqueness: {scope: :account_id }

  normalizes :email_address, with: ->(e) { e.strip.downcase }

  after_create_commit :create_customer_contact, if: :customer?

  def can_access_agent_workspace?
    agent? || admin?
  end

  def can_access_admin?
    admin?
  end

  def can_access_customer_portal?
    customer?
  end

  private

  def create_customer_contact
    create_contact!(
      account: account,
      email: email_address
    )
  end
end
