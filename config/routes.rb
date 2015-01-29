Rails.application.routes.draw do

  # get 'incidents/index'

  root to: "incidents#index"

  get '/states/:state', to: "incidents#search_state"
  # get "/incidents", to: "incidents#index"
  #

  get '/race/:race', to: "incidents#search_race"

end
