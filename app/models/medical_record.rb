class MedicalRecord < ApplicationRecord
  validates :level, presence: true
  belongs_to :user
end
