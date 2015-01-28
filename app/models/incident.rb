class Incident
  include MongoMapper::Document


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

    if existing_loc
      # puts "existing_loc!!!!"

      incident.set(:lat => existing_loc[:lat])
      incident.set(:lng => existing_loc[:lng])
    else
      # puts "GOOGLE call!!!!"


      response = HTTParty.get(path)
      puts response
      @city_lat_lng[city_details] = {
        :lat => response['results'][0]['geometry']['location']['lat'],
        :lng => response['results'][0]['geometry']['location']['lng']
      }

      incident.set(:lat => response['results'][0]['geometry']['location']['lat'])
      incident.set(:lng => response['results'][0]['geometry']['location']['lng'])




    end

  end

end
