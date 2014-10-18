module Score
  @dictionary = Dictionary.last.payload
  @similarity = Similarity.last.payload

  # @all_beers = Beer.all
  class << self

    def dictionary
      @dictionary
    end

    def similarity
      @similarity
    end

    def beer_average_rating(beer_id)
      beer_id = beer_id.to_s
      @all_averages = ActiveRecord::Base.connection.execute("SELECT beer_id, AVG(taste) FROM reviews GROUP BY beer_id").to_a
      output = @all_averages.find {|x| x["beer_id"] == beer_id}
      output["avg"]
    end

    def simpearson(o_user_id, c_user_id)
    #calculates similarity score between two users; o_user is the other user hash; c_user is the current user hash
      o_user_id = o_user_id.to_s
      c_user_id = c_user_id.to_s
      mutual = []
      @dictionary[o_user_id].each do |o_beer, o_taste|
        @dictionary[c_user_id].each do |c_beer, c_taste|
          # binding.pry
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

    def user_top_three_picks(user_id)
      picks = Array.new
      reviews = ActiveRecord::Base.connection.execute("SELECT * FROM reviews WHERE reviews.user_id =#{ActiveRecord::Base.sanitize(user_id)}").to_a

      reviews.each do |review|
        picks << review["beer_id"] if review["taste"].to_i >= 7
      end

      picks.sort.reverse.take(3)
    end

    def top_matches(c_user_id)
    # returns top 20 users with similar tastes as another user
      c_user_id = c_user_id.to_s
      scores = Array.new
      @dictionary.each do |o_user_id, ratings|
        scores << [simpearson(o_user_id, c_user_id), o_user_id]
      end
      scores = scores.sort.reverse
      scores.take(20)
      # scores = @similarity[c_user_id].sort_by do |o_user_id, sim_score|
      #   -sim_score
      # end
      # scores.take(10)
    end

    def recommendations(c_user_id)
      totals = Hash.new
      sim_sums = Hash.new
      # c_user_ratings = User.find(c_user_id).reviews
      c_user_ratings = ActiveRecord::Base.connection.execute("SELECT * FROM reviews WHERE reviews.user_id =#{ActiveRecord::Base.sanitize(c_user_id)}").to_a
      c_user_beers = Array.new
      c_user_ratings.each do |rating|
        c_user_beers << rating["beer_id"]
      end

      User.all.each do |o_user|
        if o_user.id == c_user_id
          next
        end

        sim = simpearson(c_user_id, o_user.id)
        # sim = @similarity[c_user_id][o_user.id]

        if sim == nil || sim <= 0.5
          next
        end

        o_user_ratings = ActiveRecord::Base.connection.execute("SELECT * FROM reviews WHERE reviews.user_id =#{ActiveRecord::Base.sanitize(o_user.id)}").to_a
        # o_user_ratings = User.where(id: o_user.id).first.reviews

        o_user_ratings.each do |rating|
          if !c_user_ratings.include?(rating)
            totals.default = 0
            totals[rating["beer_id"]] += rating["taste"].to_f * sim
            sim_sums.default = 0
            sim_sums[rating["beer_id"]] += sim
          end
        end
      end

      beer_rankings = Hash.new
      totals.each do |beer_id, sim_score|
        if !c_user_beers.include?(beer_id.to_s)
          beer_rankings[beer_id] = sim_score / sim_sums[beer_id]
        end
      end

      beer_rankings.sort_by{|beer_id, taste| -taste}
    end
  end
end
