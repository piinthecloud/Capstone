class IncidentsController < ApplicationController



  def index
    @incidents = Incident.where(:city.ne => nil)

    render_res

  end

  def render_res
    render json: @incidents.as_json(only: [:date_searched, :city, :state, :victim_gender, :race, :latino?, :shots_fired, :victim_age, :hit_killed?, :lat, :lng  ])

  end



  def search_state

    @incidents = Incident.where(:city.ne => nil, :state => Regexp.new(params[:state].capitalize) )

    render_res

  end

  def search_race

    @incidents = Incident.where(:city.ne => nil, :race => Regexp.new(params[:race].capitalize) )

    render_res

  end


end
