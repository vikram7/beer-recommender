class Review < ActiveRecord::Base
  belongs_to :user
  belongs_to :beer

  validates :user, presence: true
  validates :beer, presence: true
  validates :taste, presence: true, inclusion: { in: 1..10 }
end
