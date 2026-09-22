class AddAccountToKnowledgeBaseCategories < ActiveRecord::Migration[8.1]
  def change
    add_reference :knowledge_base_categories, :account, null: false, foreign_key: true

    remove_index :knowledge_base_categories, :slug

    add_index :knowledge_base_categories, [ :account_id, :slug ], unique: true
  end
end
