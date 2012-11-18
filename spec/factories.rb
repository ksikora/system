# factory tworzy nam symulacje obiektu, co jest bardzo pomocne przy testach, uzywanie fabryk opiera sie o DSL faktorów
FactoryGirl.define do
	factory :user do
		name "Michael Hartl"
		email "michael@example.com"
		password "foobar"
		password_confirmation "foobar"
	end
end
