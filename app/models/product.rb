class Product < ApplicationRecord

	extend FriendlyId
  friendly_id :name, use: :slugged

	has_one_attached :image, dependent: :purge
	has_many_attached :images, dependent: :purge
	has_one_attached :banner, dependent: :purge
	has_one_attached :technical_drawing, dependent: :purge
	has_many :product_openings, -> { order(:id) }, dependent: :destroy
	has_rich_text :short_description
	has_rich_text :description

	validates :image, attached: true, content_type: ['image/png', 'image/jpeg'],
										size: { less_than: 50.megabytes, message: 'Image maximum 50MB' }
	validates :images, content_type: ['image/png', 'image/jpeg'],
										size: { less_than: 50.megabytes, message: 'Image maximum 50MB' }
  validates :banner, attached: true, content_type: ['image/png', 'image/jpeg'],
										size: { less_than: 50.megabytes, message: 'Image maximum 50MB' }
	validates :technical_drawing, content_type: ['image/png', 'image/jpeg'],
										size: { less_than: 50.megabytes, message: 'Image maximum 50MB' }
	validates_presence_of :name
	validates_uniqueness_of :name
	validates :code, presence: true, uniqueness: true

	def should_generate_new_friendly_id?
		self.name_changed?
	end

	def self.most_recent_products(id, limit)
		where("id <> ?", id).limit(limit)
	end

	def headline
		self.short_description.to_s
	end

end
