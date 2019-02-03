class ToppagesController < ApplicationController
  def index
    if logged_in?
      @anime = current_user.animes.build  # form_for 用
      @animes = current_user.animes.order('created_at DESC').page(params[:page])
    end
  end
end
