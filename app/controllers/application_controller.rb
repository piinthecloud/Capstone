class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # def index
  #   @incidents = Incident.all
  #   render json: @incidents.as_json(only: [:date_searched, :city, :state, :race, :latino? ])
  # end
end


#date: row[1],
#    date_searched: row[2],
#    state: row[3],
#    county: row[4],
#    city: row[5],
#    agency_name: row[6],
#    victim_name: row[7],
#    victim_age: row[8],
#    victim_gender: row[9],
#    Race: row[10],
#    latino?: row[11],
#    shots_fired: row[12],
#    hit_killed?: row[13],
#    armed_unarmed?: row[14],
#    Weapon: row[15],
#    Summary: row[16],
#    source_link: row[17],
#    name_of_officer: row[18],
#    Shootings: row[19],
#    justified?: row[20],
#
