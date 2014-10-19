class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :profile_name, uniqueness: true
  validates :profile_name, presence: true, length: { in: (1..32) }

  has_many :reviews
  has_many :beers, through: :reviews
end
