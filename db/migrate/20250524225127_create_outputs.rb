class CreateOutputs < ActiveRecord::Migration[7.1]
  def change
    create_table :outputs do |t|
      t.text :book_name
      t.text :output

      t.timestamps
    end
  end
end
