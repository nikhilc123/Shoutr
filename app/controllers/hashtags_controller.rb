class HashtagsController < ApplicationController
  attr_reader :term

  def show
    @search = Search.new(term: hashtag)
  end

  private

  def hashtag
    params[:id]
  end
end