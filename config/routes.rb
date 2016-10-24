Rails.application.routes.draw do
  root 'pages#home'

  devise_for :users, controllers: { 
    registrations: 'users/registrations',
    sessions: 'users/sessions',
    passwords: 'users/passwords'
  }

  resources :payments do
    collection do
      post 'notifications', action: :notifications
    end
  end
  
  resources :comments do
    member do
      get 'respond'
    end
  end
  
  resources :contacts

  resources :movies
  resources :notes

  resources :workshops do
    resources :movies, only: :new
    resources :notes, only: :new
  end

  get 'bienvenidos', to: 'pages#welcome', as: :welcome_page
  get 'talleres-online', to: 'pages#workshops', as: :workshops_page
  get 'talleres-online/:workshop_id', to: 'pages#workshop', as: :workshop_page
  get 'ramos', to: 'pages#bouquets', as: :bouquets_page
  get 'talleres-presenciales', to: 'pages#face_workshops', as: :face_workshops_page
  get 'publicaciones', to: 'pages#publications', as: :publications_page
  get 'contacto', to: 'pages#contact', as: :contact_page

  get 'aula-virtual/videos', to: 'classroom#videos', as: :classroom_videos
  get 'aula-virtual/video/:movie_id', to: 'classroom#video', as: :classroom_video
  get 'aula-virtual/apuntes', to: 'classroom#notes', as: :classroom_notes

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
