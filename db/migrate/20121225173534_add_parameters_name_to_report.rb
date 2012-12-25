class AddParametersNameToReport < ActiveRecord::Migration
  def change
  	add_column :reports, :parameters_name, :string 
  end
end
