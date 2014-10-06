require 'rails_helper'

describe Brewer do

  describe 'validations' do
    it { should validate_presence_of(:brewer_id) }
    it { should validate_uniqueness_of(:brewer_id) }
  end

  describe 'associations' do
    it { should have_many(:beers) }
  end

end
