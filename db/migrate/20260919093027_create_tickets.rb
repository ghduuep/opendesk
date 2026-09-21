class CreateTickets < ActiveRecord::Migration[8.1]
  def change
    create_table :tickets do |t|
      t.string :subject, null: false
      t.text :description, null: false
      t.integer :status, null: false, default: 0
      t.integer :priority, null: false, default: 1
      t.string :requester_email, null: false

      t.timestamps
    end

    add_index :tickets, :status
    add_index :tickets, :requester_email
  end
end
