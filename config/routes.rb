Nonriservato::Application.routes.draw do

  devise_for :organizations

  namespace :admin do
    root :to => "projects#index"
    
    # devise_for :organizations, :skip => ['session', 'password']
    
    resources :posts
    
    resources :events
    
    resources :partners, :only => [:index]
    
    resources :projects do
      get :json_names, :on => :collection
    end
    resources :organizations do
       get :json_names, :on => :collection
    end
    resources :external_organizations do
       get :json_names, :on => :collection
    end
    
    resources :workshops
    
    resources :images, :only => [:destroy]
    # resources :external_partners, :only => [:index]
    match 'external_partners' => "organizations#edit_external_partners"
    match 'update_external_partners' => "organizations#update_external_partners"
  end

  resources :external_partnerships, :only => [:index, :show]
  resources :external_organizations, :only => [:index, :show]
  resources :posts, :only => [:index, :show, :update]
  resources :events, :only => [:index, :show, :update]
  resources :projects, :only => [:index, :show, :update]
  resources :organizations, :only => [:index, :show]
  resources :workshops, :only => [:index, :show]
  resources :pages, :only => [:new, :update, :create, :edit]
  
  match "/pages/:slug" => "pages#show"

  match 'admin/edit_profile' => "admin/organizations#edit"
  
  match 'home' => "home#index"
  # match ':action(/:section)' => 'static#:action/'
  root :to => 'home#index'
  
end
