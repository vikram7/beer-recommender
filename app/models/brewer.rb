class Brewer < ActiveRecord::Base
  self.primary_key = "brewer_id"
  has_many :beers

  validates :name, presence: true, uniqueness: true
end
