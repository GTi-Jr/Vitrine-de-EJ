Rails.application.routes.draw do
  root 'session#index'

  
  #Base/Session Routes
  get "log_in" => "session#new", :as => "log_in"

  get "/explanation" => "session#explanation"

  post "log_in" => "session#create"

  get "log_out" => "session#destroy"

  #Feedback Routes
  get "/feedback" => "feedback#feedback"
  post "/feedback" => "feedback#feedback_sent"

  #Members

  get "/members/new" => "members#new", :as => "new_member"
  post "/members" => "members#create", :as => "create_member"
  get "/members" => "members#index", :as => "members"
  get "/member/:id" => "members#show", :as => "member"
  get "/members/edit/:id" => "members#edit"
  put '/member/:id' => "members#update", :as => 'update_member'
  delete '/members/delete/:id' => "members#destroy"

  #Junior Enterprises Routes

  get "/junior_enterprises/new" => "junior_enterprises#new", :as => "new_junior_enterprise"
  get "/messages" => "junior_enterprises#messages"
  post "/junior_enterprises" => "junior_enterprises#create", :as => "create_junior_enterprise"
  get "/junior_enterprises/edit" => "junior_enterprises#edit", :as => "edit_junior_enterprise"
  put "/junior_enterprises/:id" => "junior_enterprises#update", :as => "update_junior_enterprise"
  get "/junior_enterprises" => "junior_enterprises#index", :as => "junior_enterprises"
  get "/junior_enterprise/:id" => "junior_enterprises#show", :as => "junior_enterprise"
  get "/dashboard" => "junior_enterprises#dashboard", :as => "dashboard"
  get "/find" => "junior_enterprises#find", :as => "find"
  get "/search" => "junior_enterprises#search", :as => "search"
  get "/junior_enterprises/:id/seal" => "junior_enterprises#seal"

  #Admin Routes
  get '/admin/junior_enterprises' => "junior_enterprises#index"
  get '/admin/junior_enterprises/edit/:id' => "junior_enterprises#edit"
  get '/admin/junior_enterprises/new' => "junior_enterprises#new"
  get '/admin/junior_enterprises/delete/:id' => "junior_enterprises#destroy"  
  patch "/junior_enterprise/:id" => "junior_enterprises#update"

  get '/admin/messages' => "messages#index"
  get '/admin/messages/edit/:id' => "messages#edit"
  get '/admin/messages/new' => "messages#new"
  post '/messages/:id' => "messages#create"
  post '/messages' => "messages#create"
  delete '/messages/:id' => "messages#destroy"
  get '/admin/messages/delete/:id' => "messages#destroy"  
  put "/admin/message/:id" => "messages#update", :as => "update_message"

  get '/admin/users' => "users#index", :as => 'admin_users'
  get '/admin/users/edit/:id' => "users#edit"
  get '/admin/users/new' => "users#new"
  get '/admin/users/delete/:id' => "users#destroy"

  get '/admin/members' => "members#index"
  get '/admin/members/edit/:id' => "members#edit"
  get '/admin/members/new' => "members#new"
  get '/admin/members/delete/:id' => "members#destroy"

  #Federation Routes
  get '/federation/dashboard' => "junior_enterprises#search"

  #Users Routes

    #delete "/user" => "users#destroy", :as => "destroy_user"#
  get "/users/new" => "users#new", :as => "new_user"
  post "/users" => "users#create", :as => "create_user"
  get "/users" => "users#index", :as => "users"
  get "/user/:id" => "users#show", :as => "user"
  get "/recover" => "users#recover", :as => "recover"  
  post "/recover" => "users#recover_email"
  put '/users/:id' => "users#update", :as => 'update_user'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
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

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
