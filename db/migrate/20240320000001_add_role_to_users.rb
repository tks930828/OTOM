class AddRoleToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :role, :string, default: 'user'
    add_index :users, :role
  end
end 