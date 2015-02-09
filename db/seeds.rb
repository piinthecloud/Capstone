require "csv"
#
# Incident.destroy_all
#
# CSV.foreach("public/shooting_data.csv", :headers => true,  encoding: 'ISO8859-1').each do |incident|
#   Incident.create( incident.to_h )
# end


CSV.foreach("public/utf8maybe.csv", :headers => true,  encoding: 'ISO8859-1').each do |incident|
  Feincident.create( incident.to_h )
end

Incident.add_locations


# GeoData.destroy_all

JSON.parse(File.read("public/us-states.js")).each do |x|
  GeoData.create( x )
end
