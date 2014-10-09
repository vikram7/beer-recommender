module Score
  @dictionary = Dictionary.last.payload
  @all_beers = Beer.all
  class << self

    def dictionary
      @dictionary
    end

    def simpearson(o_user_id, c_user_id)
    #calculates similarity score between two users; o_user is the other user hash; c_user is the current user hash
      o_user_id = o_user_id.to_s
      c_user_id = c_user_id.to_s
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
    # returns top 10 users with similar tastes as another user
      c_user_id = c_user_id.to_s
      scores = []
      @dictionary.each do |o_user_id, ratings|
        scores << [simpearson(o_user_id, c_user_id), o_user_id]
      end
      scores = scores.sort.reverse
      scores.take(11)
    end

    def unrated_beers(o_user_id, c_user_id)
      # find which beers current user has not rated compared to another user
      o_user_id = o_user_id.to_s
      c_user_id = c_user_id.to_s
      o_user_beers = []
      @dictionary[o_user_id].each do |beer_id, taste|
        o_user_beers << beer_id
      end
      c_user_beers = []
      @dictionary[c_user_id].each do |beer_id, taste|
        c_user_beers << beer_id
      end
      o_user_beers - c_user_beers
    end

    def expected_values_of_unrated_beers(o_user_id, c_user_id)
      o_user_id = o_user_id.to_s
      c_user_id = c_user_id.to_s
      beers = unrated_beers(o_user_id, c_user_id)
      sim_score = simpearson(o_user_id, c_user_id)
      expected_values = Hash.new
      beers.each do |beer_id|
        expected_values[beer_id] = @dictionary[o_user_id][beer_id] * sim_score
      end
      expected_values
    end

    def all_expected_values_of_unrated_beers(c_user_id)
      other_users = @dictionary.keys
      c_user_id = c_user_id.to_s
      expected_values = Hash.new
      other_users.each do |o_user_id|
        expected_values[o_user_id] = expected_values_of_unrated_beers(o_user_id, c_user_id)
      end
      expected_values
    end

    def expected_ratings_of_beers_by_beer(c_user_id)
      other_users = @dictionary.keys
      c_user_id = c_user_id.to_s
      expected_values = Hash.new([])
      all_expected_values_of_unrated_beers(c_user_id).each do |user_id, beer_ratings|
        beer_ratings.each do |beer_id, rating|
          expected_values[beer_id] += [rating] if rating > 0
        end
      end
      expected_values
    end

    def other_user_sims(c_user_id)
      other_users = @dictionary.keys
      c_user_id = c_user_id.to_s
      similarities = Hash.new(0)
      other_users.each do |o_user_id, ratings|
        similarities[o_user_id] = simpearson(o_user_id, c_user_id)
      end
      similarities
    end

    def user_reviewed_beer?(user_id, beer_id)
      user_id = user_id.to_s
      beer_id = beer_id.to_s
      @dictionary[user_id].has_key?(beer_id)
    end

    def beer_sim_sum(beer_id, c_user_id)
      c_user_id = c_user_id.to_s
      beer_id = beer_id.to_s
      other_users = @dictionary.keys
      sim_sums = Hash.new([])
      other_users.each do |user_id, ratings|
        if user_reviewed_beer?(user_id, beer_id)
          sim = simpearson(user_id, c_user_id)
          sim_sums[beer_id] += [sim] if sim > 0
        end
      end
      sim_sums[beer_id].inject(:+)
    end

    def total_by_sim_sum(beer_id, c_user_id)
      beer_id = beer_id.to_s
      c_user_id = c_user_id.to_s
      total = expected_ratings_of_beers_by_beer(c_user_id)[beer_id].inject(:+)
      sim_sum = beer_sim_sum(beer_id, c_user_id)
      if total == nil
        return 0
      else
        return total/sim_sum
      end
    end

    def beer_predictions(user_id)
      user_id = user_id.to_s
      predictions = Hash.new
      count = 1
      Beer.limit(100).each do |beer, ratings|
        total = total_by_sim_sum(beer.id, user_id)
        predictions[beer.id] = total
        puts count += 1
        puts beer.id.to_s + ": " + total.to_s
      end
      predictions
    end

    def which_beers_are_not_nil
      Beer.all.each do |beer, ratings|
        a = beer_sim_sum(beer.id, 8375)
        b = total_by_sim_sum(beer.id, 8375)
        if a != nil
          puts beer.id.to_s + ":" + b.to_s
          puts beer.id.to_s + ": " + a.to_s
        end
      end
    end
  end
end
