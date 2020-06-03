Rails.application.routes.draw do
  namespace :api, format: :json do
    resources :questions do
      collection do
        get 'random'
      end
    end
    resources :themes
    get 'room/index'
  end

  get 'welcome/index'
  get 'room/index'
  resources :questions
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end