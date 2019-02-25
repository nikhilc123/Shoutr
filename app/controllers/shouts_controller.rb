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
    case params[:shout][:content_type]
      when "TextShout" then TextShout.new(text_shout_content_params)
      when "PhotoShout" then PhotoShout.new(photo_shout_content_params)
    end
  end

  def text_shout_content_params
    #polymophic = hout.content should give textshout or image shout
    params.require(:shout).require(:content).permit(:body)
  end

  def photo_shout_content_params
    #polymophic=hout.content should give textshout or image shout
    params.require(:shout).require(:content).permit(:image)
  end

  def redirect_options_for(shout)
    if shout.persisted?
      { notice: 'Shouted succesfully' }
    else
      { alert: 'Could not Shout!' }
    end
  end
end