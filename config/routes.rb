Rails.application.routes.draw do
  api_version(module: 'Api::V1',
              header: { name: 'Accept', value: 'application/vnd.test.fun; version=1' },
              parameter: { name: 'version', value: '1' },
              path: { value: 'v1' },
              defaults: { format: 'json' },
              default: true) do
    resources :books, only: %i[index create destroy]

    post '/authenticate' => 'authentication#create'
  end
end
