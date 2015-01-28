Rails.application.routes.draw do

  # get 'incidents/index'

  root to: "incidents#index"

  get '/states/:state', to: "incidents#search"
  # get "/incidents", to: "incidents#index"
  #


end
