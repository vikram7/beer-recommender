class Style < ActiveRecord::Base
  has_many :beers

  validates :style, uniqueness: true
end
