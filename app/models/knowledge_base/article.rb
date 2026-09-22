class KnowledgeBase::Article < ApplicationRecord
  belongs_to :category, class_name: "KnowledgeBase::Category", inverse_of: :articles
  has_rich_text :body

  enum :status, { draft: 0, published: 1 }

  validates :title, presence: true
  validates :slug, presence: true, uniqueness: true

  before_validation :generate_slug, if: -> { slug.blank? && title.present? }

  private

  def generate_slug
    self.slug = title.parameterize
  end
end
