class IncidentsController < ApplicationController


  def render_res
    render json: @incidents.as_json(only: [:date_searched, :city, :state, :victim_gender, :race, :latino?, :shots_fired, :victim_age, :hit_killed?, :lat, :lng  ], methods: [:race_ethnicity])

  end




  def index
    @incidents = Incident.where(:city.ne => nil)

    render_res
  end


  def city_group
    @incidents = Incident.where(:city.ne => nil).group_by do |obj|
      [obj.lat, obj.lng]
    end

    @groups = @incidents.map do |grp|
      {loc:grp[0],
        inc:grp[1]}
      end


    render json: @groups.as_json
  end


  def race_group
    @incidents = Incident.where(:city.ne => nil).group_by do |obj|
      obj.race_ethnicity
    end

    # @groups = @incidents.map do |grp|
    #   {race:grp[0],
    #     inc:grp[1]}
    #   end



    render json: @incidents.as_json
  end


  def search_geo_data

    @states = GeoData.all
    @geodata ={"type"=>"FeatureCollection","features"=>@states.as_json}
    render json: @geodata

  end

  # def search_state
  #   @incidents = Incident.where(:city.ne => nil, :state => Regexp.new(params[:state].capitalize) )
  #
  #   render_res
  # end





end
