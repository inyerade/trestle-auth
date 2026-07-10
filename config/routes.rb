Trestle::Engine.routes.draw do
  controller "trestle/auth/sessions" do
    if Trestle.config.auth.enable_login
      get  'login'  => :new, as: :login
      post 'login'  => :create
    end

    if Trestle.config.auth.enable_logout
      get 'logout' => :destroy, as: :logout
    end
  end

  if Trestle.config.auth.recover.enabled
    scope module: "trestle/auth" do
      resources :passwords, only: [:new, :create, :edit, :update]
    end
  end
end
