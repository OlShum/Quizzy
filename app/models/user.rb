class User < ApplicationRecord
  has_and_belongs_to_many :questions
  # validates :username, presence: true, uniqueness: true
end
