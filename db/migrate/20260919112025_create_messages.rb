class CreateMessages < ActiveRecord::Migration[8.1]
  def change
    create_table :messages do |t|
      t.references :ticket, null: false, foreign_key: true
      t.references :user, foreign_key: true
      t.text :body, null: false
      t.integer :kind, null: false, default: 0

      t.timestamps
    end

    add_index :messages, [ :ticket_id, :created_at ]
  end
end
