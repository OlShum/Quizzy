class User < ApplicationRecord
  has_and_belongs_to_many :questions
  has_one :room
  # validates :username, presence: true, uniqueness: true
end
