a = Time.now
count = 1
1000.times do
  Score.simpearson(count,count+1)
  count += 1
end
puts "TIME ONE" + " : " + (Time.now - a).to_s

a = Time.now
count = 1
1000.times do
  ActiveRecord::Base.connection.execute("SELECT corr(u1.taste, u2.taste) from reviews u1 inner join reviews u2 on u2.beer_id = u1.beer_id where u2.user_id = #{count} and u1.user_id = #{count+1}").first["corr"].to_f
  count += 1
end
puts "TIME TWO" + " " + (Time.now - a).to_s


# average beer rating:
ActiveRecord::Base.connection.execute("SELECT beer_id, AVG(taste) FROM reviews GROUP BY beer_id")

