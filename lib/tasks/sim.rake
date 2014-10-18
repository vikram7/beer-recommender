namespace :similarity do
  desc "Generate an up to date dictionary of two users and thier similarity score"
  task :sim => :environment do
    @similarity = Hash.new
    User.all.each do |user1|
      start = Time.now
      right = Hash.new
      User.all.each do |user2|
        if user1 != user2
          sim = Score.simpearson(user1.id, user2.id)
          right[user2.id] = sim
        end
        @similarity[user1.id] = right
      end
    end
  Similarity.create(payload: @similarity)
  end
end
