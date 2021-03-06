namespace :dictionary do
  desc "Generate an up to date dictionary of user id and beer ratings"
  task :populate => :environment do
    @dictionary = Hash.new
    User.all.each do |user|
      right = Hash.new
      reviews = user.reviews
      convert = reviews.to_json(only: [:beer_id, :taste])
      temp = JSON.parse(convert)
      temp.each do |rating|
        right[rating["beer_id"]] = rating["taste"]
      end
      @dictionary[user.id] = right
    end
  Dictionary.create(payload: @dictionary)
  end
end
