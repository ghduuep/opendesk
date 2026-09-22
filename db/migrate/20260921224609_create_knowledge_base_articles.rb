class CreateKnowledgeBaseArticles < ActiveRecord::Migration[8.1]
  def change
    create_table :knowledge_base_articles do |t|
      t.references :category, null: false, foreign_key: { to_table: :knowledge_base_categories }
      t.string :title, null: false
      t.string :slug, null: false
      t.text :body
      t.integer :status, null: false, default: 0
      t.datetime :published_at

      t.timestamps
    end

    add_index :knowledge_base_articles, :slug, unique: true
  end
end
