class FollowersController < ApplicationController
  def index
    @user = find_user
    @followers = @user.followers
  end

  private

  def find_user
    #user_id because its nested resource
    @_user ||= User.find_by(username: params[:user_id])
  end
end