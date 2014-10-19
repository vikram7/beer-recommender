namespace :beerid do
  desc "generate a dictionary of beer ids and their names"
  task :populate => :environment do
    @dictionary = Hash.new
    Beer.all.each do |beer|
      @dictionary[beer.beer_id] = beer.name
    end
  Beeridname.create(payload: @dictionary)
  end
end
