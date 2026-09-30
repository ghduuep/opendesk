class Account < ApplicationRecord
  has_many :users, dependent: :destroy
  has_many :tickets, dependent: :destroy
  has_many :contacts, dependent: :destroy
  has_many :knowledge_base_categories, class_name: "KnowledgeBase::Category", dependent: :destroy
  has_many :knowledge_base_articles, through: :knowledge_base_categories, source: :articles

  validates :name, presence: true
  validates :subdomain, presence: true, uniqueness: { case_sensitive: false }, format: { with: /\A[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\z/ }

  normalizes :subdomain, with: ->(value) { value.strip.downcase }
end
