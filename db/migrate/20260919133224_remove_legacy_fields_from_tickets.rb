class RemoveLegacyFieldsFromTickets < ActiveRecord::Migration[8.1]
  def change
    remove_column :tickets, :description, :text
    remove_column :tickets, :requester_email, :string
  end
end
