class SessionsController < ApplicationController

	def new
	end

	def create
	  user = User.find_by_email(params[:session][:email].downcase)
	  if user && user.authenticate(params[:session][:password]) #musi zarowno istniec, jak i sie dac zautentyfikowac haslem
	    # Sign the user in and redirect to the user's show page.
	      sign_in user # zaloguj uzytkownika, sign_in nie istnieje explicite tak naprawde
	      #redirect_to user # wyrenderuj /user/id , czyli show ? o to chodzi?
	      redirect_back_or user # wyrenderuj zapamietany url, tam gdzie uzytkjownik byl przed zalogowaniem

	  else
	      flash.now[:error] = 'Invalid email/password combination' # Not quite right! # nie mamy dostepu do obiektu session, nie jest on active recordnem tylko cookie wiec tak to robimy, flash.now narzuca nam to by blad nie wyskoczyl przy kliknieciu innego linka niz przycisk submit
	      render 'new'

	  end
	end


	def destroy
	    sign_out
	    redirect_to root_url
	end


end
