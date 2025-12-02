class Article < ApplicationRecord

	extend FriendlyId
  friendly_id :title, use: :slugged

	include PublishedExtension

	default_scope { order(published_date: :asc) }

	has_one_attached :image, dependent: :purge
  has_rich_text :content
	belongs_to :category

	validates :image, attached: true, content_type: ['image/png', 'image/jpeg'],
										size: { less_than: 50.megabytes, message: 'Image maximum 50MB' }
	validates_presence_of :title
	validates_uniqueness_of :title

	def should_generate_new_friendly_id?
		self.title_changed?
	end

	def self.most_recent_articles(id, limit)
		where("id <> ?", id).limit(limit)
	end

	def headline
		self.short_description ? self.short_description : ""
	end
end
