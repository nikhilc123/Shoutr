class LikesController < ApplicationController
  def create
    current_user.like(shout)
    redirect_to root_path
  end

  def destroy
    current_user.unlike(shout)
    redirect_to root_path
  end

  private

  def shout
    #params[:id] since we are using member - routes
    # params[:shout_id] if we use nested resources - collection
    @_shout ||= Shout.find(params[:id])
  end
end
