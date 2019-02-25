class TextShout < ApplicationRecord
  validates :body, presence: true, length: { in: 10..144 }
end
