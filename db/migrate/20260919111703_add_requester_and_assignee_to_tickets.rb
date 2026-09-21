class AddRequesterAndAssigneeToTickets < ActiveRecord::Migration[8.1]
  def change
    add_reference :tickets, :requester, foreign_key: { to_table: :contacts }
    add_reference :tickets, :assignee, foreign_key: { to_table: :users }
  end
end
