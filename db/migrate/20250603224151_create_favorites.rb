class CreateFavorites < ActiveRecord::Migration[7.1]
  def change
    create_table :favorites do |t|
      t.integer :user_id
      t.integer :output_id

      t.timestamps
    end
  end
end
