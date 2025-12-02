require 'rails_helper'

RSpec.describe Article, type: :model do
  describe 'associations' do
    it { should belong_to(:category) }
    it { should have_one_attached(:image) }
    it { should have_rich_text(:content) }
  end

  describe 'validations' do
    it { should validate_presence_of(:title) }

    context 'with existing article' do
      before { create(:article) }
      it { should validate_uniqueness_of(:title) }
    end
  end

  describe 'friendly_id' do
    let(:article) { create(:article, title: 'Test Article') }

    it 'generates slug from title' do
      expect(article.slug).to eq('test-article')
    end

    it 'can be found by slug' do
      found_article = Article.friendly.find(article.slug)
      expect(found_article).to eq(article)
    end
  end

  describe 'factory' do
    it 'has a valid factory' do
      article = build(:article)
      expect(article).to be_valid
    end

    it 'attaches image' do
      article = create(:article)
      expect(article.image).to be_attached
    end
  end
end
