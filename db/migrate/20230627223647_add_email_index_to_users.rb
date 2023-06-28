class AddEmailIndexToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :add_index_to_users, :string
  end
end
