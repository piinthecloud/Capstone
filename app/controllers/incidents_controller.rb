class IncidentsController < ApplicationController


  def render_res
    render json: @incidents.as_json(only: [:date_searched, :city, :state, :victim_gender, :race, :latino?, :shots_fired, :victim_age, :hit_killed?, :lat, :lng  ])

  end

  def index
    @incidents = Incident.where(:city.ne => nil)

    render_res

  end

  def search_state

    @incidents = Incident.where(:city.ne => nil, :state => Regexp.new(params[:state].capitalize) )

    render_res

  end

  def search_geo_data

    @states = GeoData.all
    @geodata ={"type"=>"FeatureCollection","features"=>@states.as_json}
    render json: @geodata

  end




end
