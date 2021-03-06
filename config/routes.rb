Rails.application.routes.draw do
  resources :projects
  resources :sessions

  root to: "projects#index"

  get "/login" => "sessions#new"
  get "/auth/callback" => "sessions#create"
  get "/signout" => "sessions#destroy", :as => :signout
  get ":owner/:repo/backlog" => "backlog#index", as: :backlog
  get ":owner/:repo/milestones" => "milestones#index", as: :backlog_milestone
  get ":owner/:repo/milestones/:id/show" => "milestones#show", as: :milestone_details

  post ":owner/:repo/issue/create" => "issues#create", as: :create_issue
  post ":owner/:repo/issue/update" => "issues#update", as: :edit_issue
  post ":owner/:repo/milestone/create" => "milestones#create", as: :create_milestone

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
