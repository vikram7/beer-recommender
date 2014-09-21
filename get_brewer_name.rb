# # http://www.ratebeer.com/brewers/brewing-company-8481.htm

# 'http://www.ratebeer.com/brewers/brewing-company-#{brewer_id}.htm'

require 'csv'
require 'nokogiri'
require 'pry'
require 'open-uri'

file = File.read('Ratebeer.csv')
csv = CSV.parse(file, :headers => true, :header_converters => :symbol)

CSV.open("Ratebeer_brewers.csv", "w") do |line|
  line << ["brewer_id"]
end

CSV.open("Ratebeer_brewers.csv", "a") do |file|
  csv.each do |row|
    file << [row[:brewer_id]]
  end
end

File.open("use_this_brewer_csv.csv", "w+") do |file|
  file.puts File.readlines("Ratebeer_brewers.csv").uniq
end

file = File.read('use_this_brewer_csv.csv')
csv = CSV.parse(file, :headers => true, :header_converters => :symbol)

CSV.open('brewer_ids_and_names.csv', 'w') do |line|
  line << ['brewer_id', 'name']
end

CSV.open('brewer_ids_and_names.csv', 'a') do |line|
  csv.each do |row|
      brewer_id = row[:brewer_id]
      brewer_url = 'http://www.ratebeer.com/brewers/brewing-company-'+ brewer_id + '.htm'
      html = open(brewer_url)
      doc = Nokogiri::HTML(html)
      name = doc.css('h1').children.text
      line << [row[:brewer_id], name]
  end
end
