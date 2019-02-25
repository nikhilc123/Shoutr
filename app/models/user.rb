class User < ApplicationRecord
  include Clearance::User
  has_many :shouts, dependent: :destroy
  has_many :likes
  # user likes many shouts AND there is no need to create LikeShout model so use source
  # source: :shots because, Likes table will have
  # user_id: <x> like_id: <x>
  #Why source?
  # "You are renaming the shouts association to liked_shouts. If you don't provide the :source,
  # Rails will look for an association called liked_shout in the Like class."
  has_many :liked_shouts, through: :likes, source: :shout

  validates :username, presence: true, uniqueness: true

  def like(shout)
    #fill the array with records
    liked_shouts << shout
  end

  def unlike(shout)
    liked_shouts.destroy(shout)
  end

  def liked?(shout)
    #liked_shout_ids - Rails smart to tell you based on association
    liked_shout_ids.include?(shout.id)
  end

  def to_param
    username
  end
end
