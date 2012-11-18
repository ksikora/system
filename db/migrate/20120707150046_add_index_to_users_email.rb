class AddIndexToUsersEmail < ActiveRecord::Migration
  def change
		add_index :users, :email, unique: true # ta migracja zostala wygenerowana po to by rozwiazac problem unikalnosci emaili w obciazonym serwerze, dodajemy index do kolumny email w tabeli users, ktory musi byc unikalny

	# indeks dodatkowo rozwiaze nam problem z brakiem wydajnosci przy find_by_email, gdyz indeksowanie to zdecydowanie przyspiesza
  end
end
