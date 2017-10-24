Rails.application.routes.draw do
  
  get 'home/top' => "home#top"
  
  root to: "home#top"
  
  resources :comments

  devise_for :users
  resources :users, :only => [:index, :show ,:like] do
    member do
    get 'like', to: "users#like"
    get 'good', to: "users#good"
    end
    resources :comments
    resources :songs
  end
  
  resources :songs do
      collection do
        get :like
        get :latest 
      end
      
      member do
          put "like", to:    "songs#upvote"
      end
  resources :comments do
      member do
            put "good", to:  "comments#upvote"
      end
    end
  end
  
  
end

