class ShoutsController < ApplicationController

  def show
    #when you click on link_to inside _text_shout.html.erb (a record is being sent)
    @shouts = Shout.find(params[:id])
  end

  def create
    #user has many shouts
    shout = current_user.shouts.create(shout_params)
    redirect_to root_path, redirect_options_for(shout)
  end

  private

  def shout_params
    { content: content_from_params }
  end

  def content_from_params
    #content_type get from routes
    params[:content_type].new(content_params)
  end

  def content_params
    #we do not care about what attribute is being passed
    # For large scale applications, we should not permit! everything its dangerous!
    params.require(:shout).require(:content).permit!
  end

  def redirect_options_for(shout)
    if shout.persisted?
      { notice: 'Shouted succesfully' }
    else
      { alert: 'Could not Shout!' }
    end
  end
end