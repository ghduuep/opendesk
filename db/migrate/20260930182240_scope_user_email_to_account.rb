class ScopeUserEmailToAccount < ActiveRecord::Migration[8.1]
  def change
    remove_index :users, :email_address

    add_index :users, [:account_id, :email_address], unique: true
  end
end
