class Contact < ApplicationRecord

	default_scope { order(created_at: :desc) }

	attr_accessor :use_v2

  # Validations
  validates_presence_of :name, :email, :phone, :message
	validates :email, email: true

end
