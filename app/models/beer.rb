class Beer < ActiveRecord::Base
  self.primary_key = "beer_id"

  def self.search(query)
    where("name ilike ?", "%#{query}%")
  end

  has_many :reviews
  belongs_to :style
  belongs_to :brewer

  validates :name, presence: true, uniqueness: { scope: :brewer }
  validates :brewer, presence: true
  validates :style, presence: true
end
