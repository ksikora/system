class AddRememberTokenToUsers < ActiveRecord::Migration
  def change
    add_column :users, :remember_token, :string
    add_index  :users, :remember_token		# dodajemy index, bo bedziemy po tym wyszukiwali, a to przyspiesza
  end
end

