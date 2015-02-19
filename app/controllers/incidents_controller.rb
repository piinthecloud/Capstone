class IncidentsController < ApplicationController


  def render_res
    render json: @incidents.as_json(only: [:date_searched, :city, :state, :victim_gender, :victim_name, :race, :latino?, :shots_fired, :victim_age, :hit_killed?, :lat, :lng, :cause_of_death ], methods: [:race_ethnicity, :image])

  end

  def index
    @incidents = Feincident.where(:city.ne => nil)

    render_res
  end


  def search_geo_data

    @states = GeoData.all
    @geodata ={"type"=>"FeatureCollection","features"=>@states.as_json}
    render json: @geodata

  end

end

# def city_group
#   @incidents = Feincident.where(:city.ne => nil).group_by do |obj|
#     [obj.lat, obj.lng]
#   end
#
#   @groups = @incidents.map do |grp|
#     {loc:grp[0],
#       inc:grp[1]}
#     end
#
#   render json: @groups.as_json
# end
#
#
# def race_group
#   @incidents = Feincident.where(:city.ne => nil).group_by do |obj|
#     obj.race_ethnicity
#   end
#
#   render json: @incidents.as_json
# end

# def gender_count(gender)
#   Feincident.all(:victim_gender => gender).count
#
# end

# def gender_group
#   @male_count = gender_count("Male" || "male")
#   @female_count = gender_count("Female" || "female")
#
#   @incidents = Feincident.where(:city.ne => nil).group_by do |obj|
#     obj.victim_gender
#     # :male_count => @male_count,
#     # :female_count =>@female_count]
#   end
#
#
#   render json: @incidents.as_json
#
# end

#
#
# class IncidentsController < ApplicationController
#
#
#   def render_res
#     render json: @incidents.as_json(only: [:date_searched, :city, :state, :victim_gender, :race, :latino?, :shots_fired, :victim_age, :hit_killed?, :lat, :lng  ], methods: [:race_ethnicity])
#
#   end
#
#   def index
#     @incidents = Incident.where(:city.ne => nil)
#
#     render_res
#   end
#
#
#   def city_group
#     @incidents = Incident.where(:city.ne => nil).group_by do |obj|
#       [obj.lat, obj.lng]
#     end
#
#     @groups = @incidents.map do |grp|
#       {loc:grp[0],
#         inc:grp[1]}
#       end
#
#     render json: @groups.as_json
#   end
#
#
#   def race_group
#     @incidents = Incident.where(:city.ne => nil).group_by do |obj|
#       obj.race_ethnicity
#     end
#
#     render json: @incidents.as_json
#   end
#
#
#   def search_geo_data
#
#     @states = GeoData.all
#     @geodata ={"type"=>"FeatureCollection","features"=>@states.as_json}
#     render json: @geodata
#
#   end
#
#
#
#
#
#
# end
