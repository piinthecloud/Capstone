require "csv"

Incident.destroy_all

CSV.foreach("public/shooting_data.csv", :headers => true,  encoding: 'ISO8859-1').each do |incident|
  Incident.create( incident.to_h )
end

Incident.add_locations


GeoData.destroy_all

JSON.parse(File.read("public/us-states.js")).each do |x|
  GeoData.create( x )
end

# @states =["Illinois", "Nevada", "Utah", "California", "Michigan", "Kentucky", "Virginia", "New York", "Florida", "Georgia", "Maine", "New Hampshire", "Washington", "Maryland", "Colorado", "North Carolina", "Pennsylvania", "Wisconsin", "New Jersey", "Missouri", "Texas", "Connecticut", "Ohio", "Idaho", "Massachusetts", "Mississippi", "Arizona", "Louisiana", "Oregon", "South Carolina", "Indiana", "Arkansas", "Hawaii", "Iowa", "Alabama", "Rhode Island", "Alaska", "New Mexico", "Kansas", "South Dakota", "Tennessee", "Minnesota", "Vermont", "West Virginia", "Oklahoma", "District of Columbia", "Wyoming", "Montana", "Delaware"]
#
#
#
# @states.each do |state|
#
#   Incident.find_each(:state.ne => nil) do |shooting|
#     if shooting.state[5..-1] == state
#       shooting.set(:state => state)
#     end
#   end
# end
