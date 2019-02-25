class FollowedUsersController < ApplicationController
  def create
    user_to_follow = find_user
    current_user.follow(user_to_follow)
    redirect_to user_to_follow #users_object show path - Rails magic
  end

  def destroy
    user_to_unfollow = find_user
    current_user.unfollow(user_to_unfollow)
    redirect_to user_to_unfollow
  end

  private

  def find_user
    #find by user name since we added to_param method
    # params[:id] - member route, params[:user_id] - nested route
    @_user ||= User.find_by(username: params[:id])
  end
end