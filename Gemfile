source 'https://rubygems.org'

gem 'rails', '3.2.9'
gem 'therubyracer'
gem 'bootstrap-sass', '2.0.2' # sass to jezyk podobny do LESS CSS, ktorego normalnie uzywa bootstrap
gem 'bcrypt-ruby', '3.0.1'# dzieki temu bedziemy szyfrowali hasla w bazie danych
gem 'rb-readline' # aby konsola dziala

group :development, :test do
  gem 'sqlite3', '1.3.5'
  gem 'rspec-rails', '2.10.0'
  gem 'guard-rspec', '0.5.5'
end

gem 'annotate', '~> 2.4.1.beta', group: :development # generuje pożyteczne informacje przy tworzeniu modeli

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '3.2.5'
  gem 'coffee-rails', '3.2.2'
  gem 'uglifier', '1.2.3'
end

gem 'jquery-rails', '2.0.2'

group :test do
  gem 'rspec-rails','2.10.0'
  gem 'capybara', '1.1.2'
  gem 'rb-inotify', '0.8.8'
  gem 'libnotify', '0.5.9'
  gem 'guard-spork', '0.3.2'
  gem 'spork', '0.9.0'
	gem 'factory_girl_rails', '1.4.0' # do wygodnego tworzenia obiektow podczas testow
end

group :production do # czesto robimy bundle install --without production poniewaz uzywamy sqlite3 ktore wczesniej dodalismy a to jest potrzebne dla heroku gdyz on tylka postgresql uznaje.
  gem 'pg', '0.12.2'
end
