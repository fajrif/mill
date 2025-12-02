require 'rails_helper'

RSpec.describe Admin, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:full_name) }
  end

  describe 'devise modules' do
    it 'has database_authenticatable module' do
      expect(Admin.devise_modules).to include(:database_authenticatable)
    end

    it 'has trackable module' do
      expect(Admin.devise_modules).to include(:trackable)
    end
  end

  describe 'factory' do
    it 'has a valid factory' do
      admin = build(:admin)
      expect(admin).to be_valid
    end
  end

  describe 'authentication' do
    let(:admin) { create(:admin) }

    it 'can be authenticated with valid credentials' do
      expect(admin.valid_password?('password123')).to be true
    end

    it 'cannot be authenticated with invalid credentials' do
      expect(admin.valid_password?('wrongpassword')).to be false
    end
  end
end
