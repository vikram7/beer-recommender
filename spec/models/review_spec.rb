require 'rails_helper'

describe Review do

  describe 'validations' do
    it { should validate_presence_of(:user) }
    it { should validate_uniqueness_of(:user).scoped_to(:beer_id) }
    it { should validate_presence_of(:beer) }
    it { should validate_inclusion_of(:taste).in_array((1..10).to_a)}
  end

  describe 'associations' do
    it { should belong_to(:user) }
    it { should belong_to(:beer) }
  end

end
