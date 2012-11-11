PhotoUploadix::Application.routes.draw do
  #index
  get "site/index"

  #galleries root
  match  "public_gallery" ,:to => "photos#public_gallery"
  match  "private_gallery" ,:to => "users#private_gallery"

  #ajax update
  match  "update_likes", :to =>"likes#update_likes"
  match  "display_like_button", :to =>"likes#display_like_button"

   #registration confirmation routes
  resources :users do
    scope "/confirm" do
       get ':registration_token', :to => 'users#confirm_registration', :as => :confirm_registration
    end
  end

 
  resources :users do
     resources :friends do
       member do
        post 'create', :to => 'friends#create', :as => :create
        get 'confirm', :to => 'friends#confirm', :as => :confirm
        get 'confirm_ok',:to => 'friends#confirm_ok', :as => :confirm_ok
        get 'confirm_ko', :to => 'friends#confirm_ko', :as => :confirm_ko

       end
    end
  end
	

  #users/photos/albums routes
  resources :users do
    resources :photos,:albums
  end

  #session routes
  match "logout", :to => "session#destroy"
  match "login", :to => "session#create"

  resources :session


   #root
   root :to => 'site#index'


  #in case route is not found leave this
  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
   match ':controller(/:action(/:id))(.:format)'
end
