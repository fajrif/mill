class ProductOpening < ApplicationRecord
  belongs_to :product
  has_rich_text :description

  validates :title, presence: true
end
