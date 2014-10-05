require 'rails_helper'

describe User do

  describe 'validations' do
    it { should validate_presence_of(:profile_name) }
    it { should ensure_length_of(:profile_name).is_at_most(32) }
    it { should ensure_length_of(:profile_name).is_at_least(1) }
  end

  describe 'associations' do
    it { should have_many(:reviews) }
  end

end
