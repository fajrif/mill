require 'rails_helper'

RSpec.describe Feature, type: :model do
  describe 'associations' do
    it { should have_one_attached(:image) }
  end

  describe 'validations' do
    it 'validates image attachment' do
      feature = build(:feature)
      expect(feature).to be_valid
    end
  end

  describe 'factory' do
    it 'has a valid factory' do
      feature = build(:feature)
      expect(feature).to be_valid
    end

    it 'attaches image' do
      feature = create(:feature)
      expect(feature.image).to be_attached
    end
  end
end
