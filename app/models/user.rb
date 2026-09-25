class User < ApplicationRecord
  include Searchable

  searchable_by :email_address

  belongs_to :account, optional: true

  has_secure_password
  has_many :sessions, dependent: :destroy
  has_many :assigned_tickets, class_name: "Ticket", foreign_key: :assignee_id, dependent: :nullify
  has_one :contact, dependent: :nullify

  enum :role, { customer: 0, agent: 1, admin: 2 }

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

  def accessible_tickets
    if customer?
      contact&.tickets || Ticket.none
    else
      account&.tickets || Ticket.none
    end
  end

  def accessible_contacts
    if customer?
      Contact.none
    else
      account&.contacts || Contact.none
    end
  end

  def accessible_articles
    articles = account&.knowledge_base_articles || KnowledgeBase::Article.none

    customer? ? articles.published : articles
  end

  def accessible_users
    admin? ? (account&.users || User.none ) : User.none
  end

  def search(query)
    return empty_search_results if query.blank?

    {
      tickets: accessible_tickets.search(query),
      contacts: accessible_contacts.search(query),
      articles: accessible_articles.search(query).includes(:category),
      users: accessible_users.search(query)
    }
  end

  private

  def empty_search_results
    {
      tickets: Ticket.none,
      contacts: Contact.none,
      articles: KnowledgeBase::Article.none,
      users: User.none
    }
  end

  def create_customer_contact
    create_contact!(
      account: account,
      email: email_address
    )
  end
end
