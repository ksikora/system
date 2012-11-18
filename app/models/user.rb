# == Schema Information
#
# Table name: users
#
#  id              :integer         not null, primary key
#  name            :string(255)
#  email           :string(255)
#  created_at      :datetime        not null
#  updated_at      :datetime        not null
#  password_digest :string(255)
#

class User < ActiveRecord::Base   # zawarte walidację będą sprawdzane dopiero przy rządzaniu zapisania do bazy danych ( na 90% )
  attr_accessible :email, :name, :password, :password_confirmation # accesible to dostepne dla uzytkownikow obcych, takie "public"
	has_secure_password # ta metoda powoduje sprawdzanie poprawnosci rejestrowanego hasla i zapewnianie bezpiecznego hasla, zapewnia tez szyfrowanie password_digest, zajmuje sie tez autentyfikacja, dostarcza nam metody autentyfikacyjnej

	before_save { |user| user.email = email.downcase } # uzywamy tu collbacka ktory nam zrobi downcasting dla wporwadzanych maili
	before_save :create_remember_token


	validates :name, presence: true, length: {maximum: 50 } # presence jest false gdy jest null w bazie danych, np pustry string.

	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i # z duzych liter wyrazenie regularne, i na samym koncu mowi nam o obojetnosci duzych i malych liter

	validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false } # właczone uniqueness domyslnie na true + brak wrazliwosci na zanki. A i a to to samo dla niego teraz.
	
	validates :password, presence: true, length: { minimum: 6 }

	validates :password_confirmation, presence: true


  private # nie bedzie sie dalo explicite odwolac do tego pola np. w konsoli

    def create_remember_token		# funkcja ktora przypisuje w bazie polu remember_toker randomowego stringa
      self.remember_token = SecureRandom.urlsafe_base64
    end




	

end
