
class Incident
  include MongoMapper::Document

  #
  # key :blah, :field_name => "Timestamp"
  # # key :field_name => "Timestamp", Time
  #
  # key :blah, Time
  #

  def race_ethnicity

    if race == "White" && latino? == "Not of Hispanic or Latino origin" || race == "White" && latino? == "Unknown"
      "White"

    elsif latino? == "Hispanic or Latino origin"
      "Hispanic or Latino origin"

    elsif race == "American Indian or Alaska Native"
      "American Indian or Alaska Native"

    elsif race == "Black or African American"
      "Black or African American"

    elsif race == "Asian"
      "Asian"

    elsif race == "Native Hawaiian or Other Pacific Islander"
      "Native Hawaiian or Other Pacific Islander"

    elsif race == "Unknown" && latino? == "Not of Hispanic or Latino origin" || race == "Uknown" && latino? == nil
      "Unknown"


    end


  end








  def self.add_locations

    Incident.where(:city.ne => nil).each do |incident|

      get_lat_lng(incident)

    end
  end


  @city_lat_lng = {}
  def self.get_lat_lng(incident)

    city_details = [incident.state[0..1], incident.city.strip.downcase]
    existing_loc = @city_lat_lng[city_details]

    path = (URI.encode("https://maps.googleapis.com/maps/api/geocode/json?address=#{incident.city.gsub!(" ", "-")||incident.city}&components=country:US|administrative_area:#{incident.state[0..1]}"))

    puts city_details

    sleep 0.3



    if existing_loc
      # puts "existing_loc!!!!"

      incident.set(:lat => existing_loc[:lat])
      incident.set(:lng => existing_loc[:lng])
    else
      # puts "GOOGLE call!!!!"


      response = HTTParty.get(path)

      @city_lat_lng[city_details] = {
        :lat => response['results'][0]['geometry']['location']['lat'],
        :lng => response['results'][0]['geometry']['location']['lng']
      }

      incident.set(:lat => response['results'][0]['geometry']['location']['lat'])
      incident.set(:lng => response['results'][0]['geometry']['location']['lng'])




    end

  end

end
