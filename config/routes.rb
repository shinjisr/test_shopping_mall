Rails.application.routes.draw do
  get "/", to: redirect('/products')
  resources :products do
    member do
      post :checkout
    end
  end

  # Using singural form of 'resource' because of we only need one cart.
  resource :cart, only:[:show, :update, :destroy] do
    # 增加網址：用 collection 方法，在 cart route 內加入 cart/add path
    collection do
      post :add, path:'add/:id'
      patch :edit, path: 'edit/:id'
    end
    # edit :remove, on: :member
  end
end
