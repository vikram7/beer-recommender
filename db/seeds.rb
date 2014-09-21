# require 'csv'

# start_time = Time.now

# file = File.read('Ratebeer.csv')
# csv = CSV.parse(file, :headers => true, :header_converters => :symbol)
# csv.each do |row|
#   Style.create(style: row[:style])
#   User.create(profile_name: row[:profile_name], created_at: '2014-09-20 13:04:24')
#   Brewer.create(brewer_id: row[:brewer_id])
# end

# file = File.read('brewer_ids_and_names.csv')
# csv = CSV.parse(file, :headers => true, :header_converters => :symbol)
# csv.each do |row|
#   brewer = Brewer.find(row[:brewer_id])
#   brewer.update(name: row[:name])
# end

# file = File.read('Ratebeer.csv')
# csv = CSV.parse(file, :headers => true, :header_converters => :symbol)
# csv.each do |row|
#   Beer.create(beer_id: row[:beer_id], name: row[:name], brewer_id: row[:brewer_id], abv: row[:abv], style_id: Style.find_by(style: row[:style]).id)
#   Review.create(user_id: User.find_by(profile_name: row[:profile_name]).id, beer_id: row[:beer_id], taste: row[:taste], text: row[:text], appearance: row[:appearance], aroma: row[:aroma], palate: row[:palate], overall: row[:overall])
# end

# end_time = Time.now
# puts end_time - start_time

require 'csv'

start_time = Time.now

file = File.read('Ratebeer.csv')
csv = CSV.parse(file, :headers => true, :header_converters => :symbol)
csv.each do |row|
  puts "Creating style with name: #{row[:style]}"
  style = Style.find_or_create_by!(style: row[:style])

  puts "Creating user with profile_name: #{row[:profile_name]}"
  user = User.find_or_create_by!(profile_name: row[:profile_name], created_at: '2014-09-20 13:04:24')

  puts "Creating brewer with id: #{row[:brewer_id]}"
  brewer = Brewer.find_or_create_by!(brewer_id: row[:brewer_id])

  puts "Creating beer with name: #{row[:name]}"
  beer = Beer.find_or_initialize_by(row.to_hash.slice(:beer_id, :name, :abv))
  beer.style = style
  beer.brewer = brewer
  beer.save!

  review = user.reviews.find_or_initialize_by(beer: beer)
  review_attrs = row.to_hash.slice(:taste, :text, :appearance, :aroma, :palate, :overall)
  review.update_attributes!(review_attrs)
end

file = File.read('brewer_ids_and_names.csv')
csv = CSV.parse(file, :headers => true, :header_converters => :symbol)
csv.each do |row|
  Brewer.find_or_initialize_by(brewer_id: row[:brewer_id]).tap do |brewer|
    brewer.name = row[:name]
    brewer.save!
  end
end

end_time = Time.now
puts end_time - start_time
