require 'httparty'

namespace :scraper do
  desc "gets new data from Fatal Encounters"
  task get_data: :environment do

    @last_num = ScrapeData.all.last.last_row
    @num = 0

    data = HTTParty.get("https://spreadsheets.google.com/tq?tqx=out:csv&tq=OFFSET%20#{@last_num}%20&key=0Aul9Ys3cd80fdHNuRG5VeWpfbnU4eVdIWTU3Q0xwSEE&gid=0")




    data[1..-1].each do |x|
      puts x

      if x[0] != "null"
        @num += 1
        @incident = Feincident.create(
        :timestamp =>      x[0],
        :victim_name =>    x[1],
        :victim_age =>     x[2],
        :victim_gender =>  x[3],
        :victim_race =>    x[4],
        :address =>        x[7],
        :city =>           x[8],
        :state =>          x[9],
        :zipcode =>        x[10],
        :county =>         x[11],
        :agency_name =>    x[12],
        :cause_of_death => x[13],
        :summary =>        x[14],
        :source_link =>    x[16]
        )

        city_details =
        [@incident.state[0..1],
        @incident.address,
        @incident.city.strip.downcase]


        path = (URI.encode("https://maps.googleapis.com/maps/api/geocode/json?address=#{@incident.address},#{@incident.city},#{@incident.state}&key=AIzaSyCtWQQPhMFYqA3K7DCFPSn6MDi-xCAMXH8"))
        response = HTTParty.get(path)

        @city_lat_lng = {}

        @city_lat_lng[city_details] = {
          :lat => response['results'][0]['geometry']['location']['lat'],
          :lng => response['results'][0]['geometry']['location']['lng']
        }

        @incident.set(:lat => response['results'][0]['geometry']['location']['lat'])
        @incident.set(:lng => response['results'][0]['geometry']['location']['lng'])



      end
      @num
    end

    new_last_row = @last_num + @num

    ScrapeData.create(:last_row => new_last_row)

  end

end
