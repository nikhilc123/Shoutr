class ShoutsController < ApplicationController

  def show
    #when you click on link_to inside _shout.html.erb (a record is being sent)
    @shouts = Shout.find(params[:id])
  end

  def create
    #user has many shouts
    shout = current_user.shouts.create(shout_params)
    redirect_to root_path, redirect_options_for(shout)
  end

  private

  def shout_params
    params.require(:shout).permit(:body)
  end

  def redirect_options_for(shout)
    if shout.persisted?
      { notice: 'Shouted succesfully' }
    else
      { alert: 'Could not Shout!' }
    end
  end
end