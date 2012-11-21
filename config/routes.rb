SimpleApp::Application.routes.draw do

  resources :devices


  	resources :devices


	resources :users #mowi ze pod adresem /users są jakies zasoby RESTowe(do ktorych sie mozna odwolac po /id np users/1 oraz wiele innych(po prostu calego resta. np users/1/edit albo /users/new

	resources :sessions, only: [:new, :create, :destroy] # tylko wymienione restowe operacje sa dozwolone new -> wyswietlanie strony signin(GET), create -> zatwierdzanie formularza na stronie signin -> (POST), natomiast destroy jest generowane poprzez nacisniecie signout 

	match '/signup',  to: 'users#new' # wyswietl(GET) formularz rejestracji

	match '/signin',  to: 'sessions#new' # wyswietl(GET) formularz logowania, czyli tworzenia nowej sesji
	match '/signout', to: 'sessions#destroy', via: :delete # wyloguj sie, uzyj (DELETE restowego)
	# nie zadeklarowalismy create dla session czyli jest domyslna /sessions



  #get "static_pages/home"
	root :to => 'static_pages#home' # to nam zrobi ze sciezka domyslna '/' bedzie sie odwolywac do pliku home	

	

  #get "static_pages/help"
	match 'help', :to => 'static_pages#help' # get to to samo co match podobno. , to dziala bardziej implicite. teraz bedziemy odwolywali sie do /help a nie do static_pages/help, dodatkowo to nam tworzy zmienna help_path: '/help' i help_url: 'hhtp:...' ktora mozemy wszedzie uzyc


  #get "static_pages/about"
	match 'about', :to => 'static_pages#about'
	
  #get "static_pages/contact"
	match 'contact', :to => 'static_pages#contact'


  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
