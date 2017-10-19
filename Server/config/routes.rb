Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :songs, only: [:index, :create, :show, :update, :destroy] do
  	collection do
  		post '/play/:id', to: "songs#play"
  		post '/upload', to: "songs#upload"
  		post '/playCurrent', to: "songs#playCurrent"
  	end
  end
end
