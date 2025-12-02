class Question < ApplicationRecord

  # Validations
  validates_presence_of :question, :answer

end
