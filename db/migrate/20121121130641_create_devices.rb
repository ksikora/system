class CreateDevices < ActiveRecord::Migration
  def change
    create_table :devices do |t|
      t.string :name
      t.string :dtype
      t.boolean :sends_logs

      t.timestamps
    end
  end
end
