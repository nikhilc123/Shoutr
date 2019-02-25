class Like < ApplicationRecord
  belongs_to :user
  belongs_to :shout

  #check for pair user_id and shout_id are unique
  validates :user_id, uniqueness: { scope: :shout_id}
end
