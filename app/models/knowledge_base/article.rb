class KnowledgeBase::Article < ApplicationRecord
  belongs_to :category, class_name: "KnowledgeBase::Category", inverse_of: :articles
  has_rich_text :body

  enum :status, { draft: 0, published: 1 }

  validates :title, presence: true
  validates :slug, presence: true, uniqueness: { scope: :category_id }

  before_validation :generate_slug, if: -> { slug.blank? && title.present? }

  scope :search, ->(query) {
    return all if query.blank?

    term = "%#{sanitize_sql_like(query.strip)}%"

    where("knowledge_base_articles.title ILIKE :term", term: term)
  }

  def to_param
    slug
  end

  private

  def generate_slug
    self.slug = title.parameterize
  end
end
