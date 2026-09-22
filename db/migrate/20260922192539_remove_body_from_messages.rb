class RemoveBodyFromMessages < ActiveRecord::Migration[8.1]
  def change
    remove_column :messages, :body, :text
  end
end
