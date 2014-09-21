class Beer < ActiveRecord::Base
  self.primary_key = "beer_id"

  def self.search(query)
    where("name ilike ?", "%#{query}%")
  end

  has_many :reviews
  belongs_to :style
  belongs_to :brewer

  validates :name,
    presence: true, uniqueness: { scope: :brewer_id } #can't have a row where the name and brewer id are repeated
  validates :brewer_id,
    presence: true
  validates :style_id,
    presence: true
end
