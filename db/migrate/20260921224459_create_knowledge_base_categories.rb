class CreateKnowledgeBaseCategories < ActiveRecord::Migration[8.1]
  def change
    create_table :knowledge_base_categories do |t|
      t.string :name, null: false
      t.string :slug, null: false
      t.text :description
      t.integer :position, null: false, default: 0

      t.timestamps
    end

    add_index :knowledge_base_categories, :slug, unique: true
  end
end
