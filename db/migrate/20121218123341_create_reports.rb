class CreateReports < ActiveRecord::Migration
  def change
    create_table :reports do |t|
      t.string :average
      t.string :standard_deviation
      t.string :min
      t.string :max
      t.integer :device_id

      t.timestamps
    end
  end
end
