class IncidentsController < ApplicationController

  def index

    @incidents = Incident.where(:city.ne => nil)
    render json: @incidents.as_json(only: [:date_searched, :city, :state, :victim_gender, :race, :latino?, :shots_fired, :victim_age, :hit_killed?, :lat, :lng  ])

  end

  def search

    @incidents = Incident.where(:city.ne => nil, :state => params[:state])
    render json: @incidents.as_json(only: [:date_searched, :city, :state, :victim_gender, :race, :latino?, :shots_fired, :victim_age, :hit_killed?, :lat, :lng  ])


  end



end


# end
