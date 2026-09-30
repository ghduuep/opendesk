class AddSubdomainToAccounts < ActiveRecord::Migration[8.1]
  def change
    add_column :accounts, :subdomain, :string, null: false

    add_index :accounts, :subdomain, unique: true
  end
end
