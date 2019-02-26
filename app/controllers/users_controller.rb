class UsersController < Clearance::UsersController

  def new
    @user = User.new
  end

  def show
    @user = User.find_by(username: params[:id])
    # before
    # @shouts = @user.shouts
    # after
    # 1.dashboard page should give user and its followed user shouts
    # 2.user page should give that user's shouts
    # 1 + 2 = this commit
    @timeline = Timeline.new([@user])
  end

  private

  def user_params
    params.require(:user).permit(:username, :email, :password)
  end
end
