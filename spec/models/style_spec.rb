require 'rails_helper'

describe Style do

  describe 'validations' do
    it { should validate_uniqueness_of(:style) }
  end

  describe 'associations' do
    it { should have_many(:beers) }
  end

end
