require 'rails_helper'

RSpec.describe Contact, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:message) }
  end

  describe 'factory' do
    it 'has a valid factory' do
      contact = build(:contact)
      expect(contact).to be_valid
    end
  end
end
