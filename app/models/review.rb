class Review < ActiveRecord::Base
  belongs_to :user
  belongs_to :beer

  validates :user_id,
    presence: true, uniqueness: { scope: :beer_id } #can't have duplicate row that has same user and beer
  validates :beer_id,
    presence: true
  validates :taste,
    presence: true

    #index on #1
end
