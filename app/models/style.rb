class Style < ActiveRecord::Base
  has_many :beers

  validates :style, presence: true, uniqueness: true
end
