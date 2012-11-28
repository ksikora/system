class CreateLogs < ActiveRecord::Migration
  def change
    create_table :logs do |t|
      t.integer :device_id
      t.string :content
      t.integer :generation_date

      t.timestamps
    end
		add_index :logs, [:device_id]
  end
end
