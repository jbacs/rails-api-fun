Rails.application.routes.draw do
  api_version(module: 'Api::V1',
              header: { name: 'Accept', value: 'application/vnd.test.fun; version=1' },
              parameter: { name: 'version', value: '1' },
              path: { value: 'v1' },
              defaults: { format: 'json' },
              default: true) do
    resources :books, only: %i[index create destroy]
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  
end
