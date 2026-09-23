class KnowledgeBase::Category < ApplicationRecord
  belongs_to :account

  has_many :articles, class_name: "KnowledgeBase::Article", foreign_key: :category_id, dependent: :destroy, inverse_of: :category
  validates :name, presence: true
  validates :slug, presence: true, uniqueness: { scope: :account_id }

  before_validation :generate_slug, if: -> { slug.blank? && name.present? }

  def to_param
    slug
  end

  private

  def generate_slug
    self.slug = name.parameterize
  end
end
