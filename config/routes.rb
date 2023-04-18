Rails.application.routes.draw do
  devise_for :customers,skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }

  scope module: :public do
    get    root to: 'homes#top'
    get    'about'                   => 'homes#about'
    get    '/customers/secession'    => 'customers#secession'
    patch  '/customers/withdrawal'   => 'customers#withdrawal'
    delete '/cart_items/destroy_all' => 'cart_items#destroy_all'
    post   '/orders/confirm'         => 'orders#comfirm'
    get    '/orders/thanks'          => 'orders#thanks'

    resources :items,       only: [:index, :show]
    resources :customers,   only: [:show, :edit, :update]
    resources :cart_items,  only: [:index, :update, :destroy, :create]
    resources :orders,      only: [:new, :create, :index, :show]
    resources :addresses,   only: [:index, :edit, :create, :update, :destroy]
  end

  namespace :admin do
    get  root to: 'homes#top'

    resources :items,       only: [:index, :new, :create, :show, :edit, :update]
    resources :genres,      only: [:index, :create, :edit, :update]
    resources :customers,   only: [:index, :show, :edit, :update]
    resources :orders,      only: [:show, :update]
    resources :productions, only: [:update]
  end


  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
