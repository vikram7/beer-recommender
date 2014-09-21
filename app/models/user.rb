#user
class User < ActiveRecord::Base
  has_many :reviews

  validates :profile_name,
    presence: true, uniqueness: true

    #add index for efficiency, add constraints  (db constraint, model constraint)
end
