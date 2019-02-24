class Shout < ApplicationRecord
  belongs_to :user

  validates :body, presence: true, length: { in: 10..144 }
  validates :user, presence: true
end
