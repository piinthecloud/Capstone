
class Feincident
  include MongoMapper::Document


  def race_ethnicity

    if race == "European-American/White"
      "White"

    elsif race == "Hispanic/Latino"
      "Hispanic or Latino origin"

    elsif race == "Native American/Alaskan"
      "American Indian or Alaska Native"

    elsif race == "African-American/Black"
      "Black or African American"

    elsif race == "Asian"
      "Asian"

    elsif race == "Native Hawaiian or Other Pacific Islander"
      "Native Hawaiian or Other Pacific Islander"

    else
      "Unknown"

    end


  end

  def image
    if image_of_deceased == nil
      "img/noimage.png"
    else
      image_of_deceased
    end

  end

  def self.add_locations

    Feincident.where(:city.ne => nil, :lat => nil).each do |incident|

      get_lat_lng(incident)

    end
  end


  @city_lat_lng = {}

  def self.get_lat_lng(incident)

    city_details = [incident.state[0..1], incident.address, incident.city.strip.downcase]
    existing_loc = @city_lat_lng[city_details]

    path = (URI.encode("https://maps.googleapis.com/maps/api/geocode/json?address=#{incident.address},#{incident.city},#{incident.state}&components=country:US&key=AIzaSyCtWQQPhMFYqA3K7DCFPSn6MDi-xCAMXH8"))


    if existing_loc


      incident.set(:lat => existing_loc[:lat])
      incident.set(:lng => existing_loc[:lng])
    else


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
