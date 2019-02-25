class FollowingRelationship < ApplicationRecord
  #follower because - find all the followed_users
  # follower_id is nothing but user id
  # a user follows b.. increase the count of b
  # and then increase the count of a
  belongs_to :follower, class_name: 'User', counter_cache: :followed_users_count
  belongs_to :followed_user, class_name: 'User', counter_cache: :followers_count
end
