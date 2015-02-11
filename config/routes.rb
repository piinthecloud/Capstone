Rails.application.routes.draw do

  # get "/incidents", to: "incidents#index"
  # get '/race/:race', to: "incidents#search_race"
  # get 'incidents/index'
  # get '/city/',         to: "incidents#city_group"
  # get '/race/',         to: "incidents#race_group"
  # get '/gender/',       to: "incidents#gender_group"


  root                  to: "incidents#index"

  get '/geodata/',      to: "incidents#search_geo_data"






end
