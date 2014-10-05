class Review < ActiveRecord::Base
  belongs_to :user
  belongs_to :beer

  validates :user_id, presence: true, uniqueness: { scope: :beer_id }
  validates :beer_id, presence: true
  validates :taste, presence: true, inclusion: { in: 1..10 }
end
