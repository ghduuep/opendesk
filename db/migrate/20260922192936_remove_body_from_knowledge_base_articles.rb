class RemoveBodyFromKnowledgeBaseArticles < ActiveRecord::Migration[8.1]
  def change
    remove_column :knowledge_base_articles, :body, :text
  end
end
