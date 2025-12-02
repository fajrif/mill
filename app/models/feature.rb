class Feature < ApplicationRecord

	has_one_attached :image, dependent: :purge

	validates :image, attached: true, content_type: ['image/png', 'image/jpeg'],
										size: { less_than: 50.megabytes, message: 'Image maximum 50MB' }
  # Validations
  validates_presence_of :name, :description
  validates_uniqueness_of :name

end
