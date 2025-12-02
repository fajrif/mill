require 'rails_helper'

RSpec.describe Project, type: :model do
  describe 'associations' do
    it { should have_one_attached(:image) }
    it { should have_many_attached(:images) }
    it { should have_one_attached(:banner) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }

    context 'with existing project' do
      before { create(:project) }
      it { should validate_uniqueness_of(:name) }
    end
  end

  describe 'friendly_id' do
    let(:project) { create(:project, name: 'Luxury Home') }

    it 'generates slug from name' do
      expect(project.slug).to eq('luxury-home')
    end

    it 'can be found by slug' do
      found_project = Project.friendly.find(project.slug)
      expect(found_project).to eq(project)
    end

    it 'regenerates slug when name changes' do
      project.update(name: 'Modern House')
      expect(project.slug).to eq('modern-house')
    end
  end

  describe '.most_recent_projects' do
    let!(:project1) { create(:project, name: 'Project 1') }
    let!(:project2) { create(:project, name: 'Project 2') }
    let!(:project3) { create(:project, name: 'Project 3') }

    it 'returns projects excluding the given id' do
      results = Project.most_recent_projects(project1.id, 2)
      expect(results).not_to include(project1)
      expect(results.count).to eq(2)
    end
  end

  describe '#headline' do
    it 'returns short_description when present' do
      project = build(:project, short_description: 'Test description')
      expect(project.headline).to eq('Test description')
    end

    it 'returns empty string when short_description is nil' do
      project = build(:project, short_description: nil)
      expect(project.headline).to eq('')
    end
  end

  describe 'factory' do
    it 'has a valid factory' do
      project = build(:project)
      expect(project).to be_valid
    end

    it 'attaches image and banner' do
      project = create(:project)
      expect(project.image).to be_attached
      expect(project.banner).to be_attached
    end
  end
end
