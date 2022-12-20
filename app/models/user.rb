class User < ApplicationRecord
  has_many :medical_records, dependent: :destroy
end
