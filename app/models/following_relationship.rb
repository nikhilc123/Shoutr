class FollowingRelationship < ApplicationRecord
  #follower because - find all the followed_users
  # follower_id is nothing but user id
  belongs_to :follower, class_name: 'User'
  belongs_to :followed_user, class_name: 'User'
end
