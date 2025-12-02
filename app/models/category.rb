class Category < ApplicationRecord

	default_scope { order(id: :asc) }

	validates_presence_of :name
	validates_uniqueness_of :name

	has_many :articles

end
