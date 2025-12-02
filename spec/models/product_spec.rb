require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'associations' do
    it { should have_one_attached(:image) }
    it { should have_one_attached(:banner) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }

    context 'with existing product' do
      before { create(:product) }
      it { should validate_uniqueness_of(:name) }
    end

    it 'validates image attachment' do
      product = build(:product)
      expect(product).to be_valid
    end
  end

  describe 'friendly_id' do
    let(:product) { create(:product, name: 'Swing Series') }

    it 'generates slug from name' do
      expect(product.slug).to eq('swing-series')
    end

    it 'can be found by slug' do
      found_product = Product.friendly.find(product.slug)
      expect(found_product).to eq(product)
    end

    it 'regenerates slug when name changes' do
      product.update(name: 'Fix Window Series')
      expect(product.slug).to eq('fix-window-series')
    end
  end

  describe '.most_recent_products' do
    let!(:product1) { create(:product, name: 'Product 1') }
    let!(:product2) { create(:product, name: 'Product 2') }
    let!(:product3) { create(:product, name: 'Product 3') }

    it 'returns products excluding the given id' do
      results = Product.most_recent_products(product1.id, 2)
      expect(results).not_to include(product1)
      expect(results.count).to eq(2)
    end
  end

  describe '#headline' do
    it 'returns short_description when present' do
      product = build(:product, short_description: 'Test description')
      expect(product.headline).to eq('Test description')
    end

    it 'returns empty string when short_description is nil' do
      product = build(:product, short_description: nil)
      expect(product.headline).to eq('')
    end
  end

  describe 'factory' do
    it 'has a valid factory' do
      product = build(:product)
      expect(product).to be_valid
    end

    it 'attaches image and banner' do
      product = create(:product)
      expect(product.image).to be_attached
      expect(product.banner).to be_attached
    end
  end
end
