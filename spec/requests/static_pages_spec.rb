require 'spec_helper'
=begin
describe "Static pages" do

  let(:base_title) { "Ruby on Rails Tutorial Sample App" } #definiujemy sobie makro dla stringa zeby w kolko tego samego nie przepisyw

  describe "Home page" do

    it "should have the h1 'Sample App'" do
      visit root_path # root_path to to samo co '/static_pages/home' (bo se stworzylismy zmienna w pliku route.rb matchem
      page.should have_selector('h1', :text => 'Sample App') # selektor to po prostu znacznik ?
    end

    it "should have the title 'Home'" do
      visit root_path
      page.should have_selector('title', :text => "#{base_title} | Home") # tak wyluskujemy stringa ze zmiennej base_title.
    end
  end

  describe "Help page" do

    it "should have the h1 'Help'" do
      visit help_path
      page.should have_selector('h1', :text => 'Help')
    end

    it "should have the title 'Help'" do
      visit help_path
      page.should have_selector('title', :text => "#{base_title} | Help")
    end
  end

  describe "About page" do

    it "should have the h1 'About Us'" do
      visit about_path
      page.should have_selector('h1', :text => 'About Us')
    end

    it "should have the title 'About Us'" do
      visit about_path
      page.should have_selector('title', :text => "#{base_title} | About Us")
    end
  end

  describe "Contact page" do

    it "should have the h1 'Contact'" do
      visit contact_path
      page.should have_selector('h1', :text => 'Contact')
    end

    it "should have the title 'Contact'" do
      visit contact_path
      page.should have_selector('title', :text => "#{base_title} | Contact")
    end
  end
end
=end

describe "Static pages" do # korzystamy z subjectu ktory automatycznie dostarczy obiekt page dla jego metody should 

  subject { page }

  describe "Home page" do
    before { visit root_path } # korzystamy z akcji wspolnej, ktora polega na wejsciu na stronke dla kazdego it

    it { should have_selector('h1',    text: 'Sample App') }
    it { should have_selector('title', text: full_title('')) } # korzystamy z metody full_title znajdujacej sie w support/utilities.rb
    																		# jest ona identyczna do metody z application_helper
  end

  describe "Help page" do
    before { visit help_path }

    it { should have_selector('h1',    text: 'Help') }
    it { should have_selector('title', text: full_title('Help')) }
  end

  describe "About page" do
    before { visit about_path }

    it { should have_selector('h1',    text: 'About') }
    it { should have_selector('title', text: full_title('About Us')) }
  end

  describe "Contact page" do
    before { visit contact_path }

    it { should have_selector('h1',    text: 'Contact') }
    it { should have_selector('title', text: full_title('Contact')) }
  end
end
