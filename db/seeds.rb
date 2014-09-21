require 'csv'

start_time = Time.now

file = File.read('Ratebeer.csv')
csv = CSV.parse(file, :headers => true, :header_converters => :symbol)
csv.each do |row|
  Style.create(style: row[:style])
  User.create(profile_name: row[:profile_name], created_at: '2014-09-20 13:04:24')
  Brewer.create(brewer_id: row[:brewer_id])
end

file = File.read('brewer_ids_and_names.csv')
csv = CSV.parse(file, :headers => true, :header_converters => :symbol)
csv.each do |row|
  brewer = Brewer.find(row[:brewer_id])
  brewer.update(name: row[:name])
end

file = File.read('Ratebeer.csv')
csv = CSV.parse(file, :headers => true, :header_converters => :symbol)
csv.each do |row|
  Beer.create(beer_id: row[:beer_id], name: row[:name], brewer_id: row[:brewer_id], abv: row[:abv], style_id: Style.find_by(style: row[:style]).id)
  Review.create(user_id: User.find_by(profile_name: row[:profile_name]).id, beer_id: row[:beer_id], taste: row[:taste], text: row[:text], appearance: row[:appearance], aroma: row[:aroma], palate: row[:palate], overall: row[:overall])
end

end_time = Time.now
puts end_time - start_time
