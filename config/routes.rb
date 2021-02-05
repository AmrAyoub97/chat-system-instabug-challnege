Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  put '/applications', to: 'applications#update'
  get '/applications/list', to: 'applications#list_applications'
  resources :applications, controller: "applications", only: [:index, :create]
  resources :chats, controller: "chats", only: [:index, :create, :show] do
    resources :messages, controller: "messages", only: [:index, :create, :update, :show]
  end
  get '/search', to: 'messages#search'
end

# Header ['X-Application-Token']
#
# GET /application -- List All Applications
# GET /chat -- List All Chats
# GET /message -- List All Messages
# GET /chat/:number -- List All Chats
# GET /message -- List All Messages
# GET /search?application=token&chat=number&query=text -- Search Messages
#
# POST /application -- Add Application
# POST /chat -- Add Chat
# POST /chat/:number/message -- Add Message
#
# PUT /application -- Update Application
# PUT /chat/:number -- Update Chat
# PUT /chat/:number/message/:number -- Update Message
