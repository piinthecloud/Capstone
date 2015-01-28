# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
require "csv"

Incident.destroy_all

CSV.foreach("public/shooting_data.csv", :headers => true,  encoding: 'ISO8859-1').each do |incident|
  Incident.create( incident.to_h )
end

Incident.add_locations
