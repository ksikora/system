class AddPasswordDigestToUsers < ActiveRecord::Migration
  def change
    add_column :users, :password_digest, :string # ta migracja dodaje kolumne z zakodowanym hasłem
  end
end
