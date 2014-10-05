require 'csv'

start_time = Time.now

file = File.read('Ratebeer.csv')
csv = CSV.parse(file, :headers => true, :header_converters => :symbol)
count = 0
csv.each do |row|
  puts "Creating style with name: #{row[:style]}"
  style = Style.find_or_create_by!(style: row[:style])

  puts "Creating user with profile_name: #{row[:profile_name]}"

  if !User.find_by(profile_name: row[:profile_name])
    user = User.create!(profile_name: row[:profile_name], created_at: '2014-09-20 13:04:24', email: "email#{count}@email.com", password: "passwordpassword")
  else
    user = User.find_by(profile_name: row[:profile_name])
  end
  count += 1

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
