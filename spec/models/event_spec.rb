require 'rails_helper'

RSpec.describe Event, type: :model do
  describe 'associations' do
    it { should have_one_attached(:image) }
    it { should have_rich_text(:content) }
  end

  describe 'validations' do
    it { should validate_presence_of(:title) }

    context 'with existing event' do
      before { create(:event) }
      it { should validate_uniqueness_of(:title) }
    end
  end

  describe 'friendly_id' do
    let(:event) { create(:event, title: 'Test Event') }

    it 'generates slug from title' do
      expect(event.slug).to eq('test-event')
    end

    it 'can be found by slug' do
      found_event = Event.friendly.find(event.slug)
      expect(found_event).to eq(event)
    end
  end

  describe 'factory' do
    it 'has a valid factory' do
      event = build(:event)
      expect(event).to be_valid
    end

    it 'attaches image' do
      event = create(:event)
      expect(event.image).to be_attached
    end
  end
end
