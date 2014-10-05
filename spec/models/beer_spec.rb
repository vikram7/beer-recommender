require 'rails_helper'

describe Beer do

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_uniqueness_of(:name).scoped_to(:brewer) }
    it { should validate_presence_of(:brewer) }
    it { should validate_presence_of(:style) }
  end

  describe 'associations' do
    it { should have_many(:reviews) }
    it { should belong_to(:style) }
    it { should belong_to(:brewer) }
  end

end
