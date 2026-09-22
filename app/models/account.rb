class Account < ApplicationRecord
  has_many :users, dependent: :destroy
  has_many :tickets, dependent: :destroy
  has_many :contacts, dependent: :destroy
  has_many :knowledge_base_categories, class_name: "KnowledgeBase::Category", dependent: :destroy
  has_many :knowledge_base_articles, through: :knowledge_base_categories, source: :articles


  validates :name, presence: true
end
