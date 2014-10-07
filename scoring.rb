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

def simpearson(o_user_id, c_user_id)
#calculates similarity score between two users; o_user is the other user hash; c_user is the current user hash
  mutual = []
  @dictionary[o_user_id].each do |o_beer, o_taste|
    @dictionary[c_user_id].each do |c_beer, c_taste|
      mutual << [o_taste, c_taste] if o_beer == c_beer
    end
  end
  n = mutual.length
  return 0 if n == 0

  o_sum = 0
  c_sum = 0
  o_sum_squared = 0
  c_sum_squared = 0
  psum = 0
  mutual.each do |ratings|
    o_sum += ratings.first
    c_sum += ratings.last
    o_sum_squared += ratings.first * ratings.first
    c_sum_squared += ratings.last * ratings.last
    psum += ratings.first * ratings.last
  end

  numerator = psum - (o_sum * c_sum / n)
  denominator = Math.sqrt((o_sum_squared - (o_sum)**2/n) * (c_sum_squared - (c_sum)**2/n))
  if denominator == 0
    return 0
  else
    numerator/denominator
  end
end

def top_matches(c_user_id)
# ordered list of people with similar tastes to specified person
# lets user see other users similar to that user
  scores = []
  @dictionary.each do |o_user_id, ratings|
    scores << [simpearson(o_user_id, c_user_id), o_user_id]
  end
  scores = scores.sort.reverse
  scores.take(10)
end

def user_unrated_beers
  # find which beers the user has not rated
  beers = []
  Beer.all.each do |beer|
    beers << beer.id
  end
  c_user_beers = []
  @dictionary[c_user_id].each do |beer_id, taste|
    c_user_beers << beer_id
  end
  beers.uniq - c_user_beers.uniq
end

def expected_values_of_unrated_beers(o_user_id, c_user_id)
  unrated_beers = user_unrated_beers
  sim_score = simpearson(o_user_id, c_user_id)
  expected_values = Hash.new
  unrated_beers.each do |beer_id|
    expected_values[beer_id] = @dictionary[o_user_id][beer_id] * sim_score
  end
  expected_values
end

def all_expected_values_of_unrated_beers(c_user_id)

end
