dictionary = Hash.new
User.all.each do |user|
  right = Hash.new
  reviews = user.reviews
  convert = reviews.to_json(only: [:beer_id, :taste])
  temp = JSON.parse(convert)
  temp.each do |rating|
    right[rating["beer_id"]] = rating["taste"]
  end
  dictionary[user.id] = right
end

def simpearson(o_user_id, c_user_id)
#calculates similarity score between two users; o_user is the other user hash; c_user is the current user hash
  mutual = []
  dictionary[o_user_id].each do |o_beer, o_taste|
    dictionary[c_user_id].each do |c_beer, c_taste|
      if o_beer == c_beer
        mutual << [o_taste, c_taste]
      end
    end
  end
  n = mutual.length
  if n == 0
    return 0
  else
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
  end
  numerator = psum - (o_sum * c_sum / n)
  denominator = Math.sqrt((o_sum_squared - (o_sum)**2 / n) * ((c_sum_squared - (c_sum)**2 / n))
  return numerator / denominator
end

def top_matches(dictionary, c_user_id)
# ordered list of people with similar tastes to specified person
# lets user see other users similar to that user
  scores = []
  dictionary.each do |o_user_id, ratings|
    scores << [simpearson(o_user_id, c_user_id), o_user_id]
  end
  scores.sort.reverse
end


