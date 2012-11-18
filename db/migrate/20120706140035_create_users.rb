# migracja jest mechanizmem tworzacym baze danych na podstawie kodu rubiego(dokonuje object-relational mappingu). mapuje ona rubiego na sql'a. Active record jest biblioteka sluzaca temu celowi. wykonanie(wpuszczenie) tej migracji spowoduje stworzenie bazy danych okreslonej ponizej(lub jej update jesli istnieje), stworzy sie w plkiu db/development.sqlite3
class CreateUsers < ActiveRecord::Migration 
  def change
    create_table :users do |t|
      t.string :name
      t.string :email

      t.timestamps # tworzy columny "crated_at i updated_at", automatycznie sie beda wypelniac przy towrzeniu nowych urzytkownikow
    end
  end
end
