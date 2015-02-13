require 'httparty'

namespace :scraper do
  desc "gets new data from Fatal Encounters"
  task get_data: :environment do

    @last_num = ScrapeData.all.last.last_row

    data = HTTParty.get("https://spreadsheets.google.com/tq?tqx=out:csv&tq=OFFSET%20#{@last_num}%20&key=0Aul9Ys3cd80fdHNuRG5VeWpfbnU4eVdIWTU3Q0xwSEE&gid=0")

    @num = 0
    data[1..-1].each do |x|

      if x[0] != "null"
        @num += 1
      Test.create(
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
      end
      @num
    end

    new_last_row = @last_num + @num

    ScrapeData.create(:last_row => new_last_row)

  end

end
