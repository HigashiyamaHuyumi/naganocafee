Rails.application.routes.draw do
	# 顧客用
	# URL /customers/sign_in ...
	devise_for :customers, skip: [:passwords], controllers: {
		registrations: "public/registrations",
		sessions: 'public/sessions'
	}

	scope module: 'public' do
		get '/customers/my_page', to: 'customers#my_page', as: 'customers_my_page' #マイページ用のルート
		get '/customers/information/edit', to: 'customers#edit', as: 'customers_information_edit'
		resources :customers, only: [:update] do # 顧客リソース用のルートを追加
		  get :confirm, on: :member # 退会確認ページ用のルート
      patch :withdrawal, on: :member # 退会処理用のルート
		end
		resources :items, only: [:index, :show] #顧客用のitemsルート
		resources :cart_items, only: [:create, :index, :update, :destroy] do
      collection do
        delete :destroy_all
      end
    end
    post '/orders/confirmation', to: 'orders#confirmation', as: 'orders_confirmation' #注文情報確認ページルート
  	get '/orders/complete', to: 'orders#complete', as: 'orders_complete' #注文情報確認ページルート
    resources :orders, only: [:new, :create, :index, :show]
	end

	namespace :admin do
		resources :items,only: [:index, :new, :create, :show, :edit, :update, :destroy] # 管理者用の items ルート
	  resources :customers,only: [:index, :show, :edit, :update] # 管理者用の customers ルート
    resources :orders,only: [:show, :index]
    resources :orders_detail,only: [:show]
	end

	# 管理者用
	# URL /admin/sign_in ...
	devise_for :admin, skip: [:registrations, :passwords], controllers: {
		sessions: "admin/sessions"
	}

	# For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
	root to: "homes#top"
	get '/about', to: 'homes#about', as: 'home_about' #aboutページルート
  get '/items', to: 'public/items#index', as: 'item_index' #商品一覧ページルート

  get '/items/:id', to: 'public/items#show', as: 'item_show' #商品ページルート
  get '/cart_items', to: 'public/cart_items#index', as: 'cart_items_index' #カートページルート
end
