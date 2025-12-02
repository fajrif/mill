class Admin < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :trackable, :validatable

  # Validations
  validates_presence_of :email, :full_name
	validates :email, email: true
  validates_uniqueness_of :email

end
