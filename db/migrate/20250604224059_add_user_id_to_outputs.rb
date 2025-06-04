class AddUserIdToOutputs < ActiveRecord::Migration[7.1]
  def change
    add_column :outputs, :user_id, :integer
  end
end
