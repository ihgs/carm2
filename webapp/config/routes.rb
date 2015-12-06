Rails.application.routes.draw do


  namespace :admin do
    resources :daily_reports
  end
  devise_for :users, path: "auth",
             :controllers => {:registrations => "users/registrations"}

  namespace :api do
    post 'stamp/' => 'stamp#index'
  end

  namespace :admin do
    root 'curriculums#index'

    resources :schools
    get 'students/test_results/:id' => 'students#test_results'

    resources :students
    resources :school_tests

    get 'stamp/' => 'stamp#index'
    get 'stamp/:id' => 'stamp#show'

    get 'curriculums/' => 'curriculums#index'
    get 'learning_level_maps/:id' => 'learning_level_maps#show'
    get 'learning_level_maps/:id/network' => 'learning_level_maps#network'
    put 'learning_level_maps/:id' => 'learning_level_maps#update'

    post 'school_test_results/' => 'school_test_results#create'
    put  'school_test_results/' => 'school_test_results#update'

    get 'attached_files/' => 'attached_files#index'
  end
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'
  root 'admin/curriculums#index'
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
