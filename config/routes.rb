Rails.application.routes.draw do
	# 顧客用
	# URL /customers/sign_in ...
	devise_for :customers, skip: [:passwords], controllers: {
		registrations: "public/registrations",
		sessions: 'public/sessions'
	}
	
	scope module: 'public' do
		resources :customers, only: [:show, :edit, :update] do # 顧客リソース用のルートを追加
		  get :confirm, on: :member # 退会確認ページ用のルート
      patch :withdrawal, on: :member # 退会処理用のルート
		end
		resources :items, only: [:index, :show] # 顧客用の items ルート
		resources :cart_items, only: [:create, :index] # 顧客用の items ルート
	end
	
	namespace :admin do
		resources :items,only: [:index, :new, :create, :show, :edit, :update, :destroy] # 管理者用の items ルート
	  resources :customers,only: [:index, :show, :edit, :update] # 管理者用の customers ルート
	end

	# 管理者用
	# URL /admin/sign_in ...
	devise_for :admin, skip: [:registrations, :passwords], controllers: {
		sessions: "admin/sessions"
	}
	
	# For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
	root to: "homes#top"
	get '/about', to: 'homes#about', as: 'home_about' #aboutページルート
	get '/customers', to: 'admin/customers#index', as: 'customers_index' #会員一覧ページルート
  get '/items', to: 'public/items#index', as: 'item_index' #商品一覧ページルート
  get '/items/:id', to: 'public/items#show', as: 'item_show' #商品ページルート
end
