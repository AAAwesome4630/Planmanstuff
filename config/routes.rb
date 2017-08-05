Rails.application.routes.draw do
  resources :individual_quizzes
  resources :quizzes
  resources :admin_announcements
  resources :individual_tests
  resources :individual_assignments
  devise_for :administrators
  devise_for :teachers
  devise_for :students
  devise_for :users
  resources :classrooms 
  resources :sc_relationships
  resources :assignments
  resources :tests
  resources :announcements
  resources :t_files 
  resources :schools do 
    resources :administrators
  end


  root 'pages#index'

  get 'home' =>'pages#home'

  get 'find' => 'pages#find'

  get 'profile' => 'pages#profile'
  
  get 'newclassroom' =>'forms#newclassroom'
  
  get 'classroom/:id' =>'pages#classroom'

  get 'classrooms/:id/join/:token' => 'pages#classlink'
  #get 'classlink/:token' => 'pages#classlink'
  post 'auth_student' => 'authentication#authenticate_student'
  post 'auth_teacher' => 'authentication#authenticate_teacher'
  namespace :api do
    root 'pages#index'
    get 'student' => 'spages#index'
    get 'teacher' => 'tpages#index'
    resources :classrooms
    resources :sc_relationships
    resources :assignments
    resources :tests
  end
  

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
