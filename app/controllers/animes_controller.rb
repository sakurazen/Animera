class AnimesController < ApplicationController
  before_action :require_user_logged_in
  before_action :correct_user, only: [:destroy]
  
  def index
    @animes = Anime.all.page(params[:page])
  end
  
  def show
    if logged_in?
      @review = current_user.reviews.build  # form_for 用
      @reviews = current_user.reviews.order('episode_no DESC').page(params[:page])
    end
    @anime = Anime.find(params[:id])
  end

  def new
    @anime = Anime.new
  end

  def create
    @anime = current_user.animes.build(anime_params)
    if @anime.save
      flash[:success] = 'アニメを登録しました。'
      redirect_to root_url
    else
      @animes = current_user.animes.order('created_at DESC').page(params[:page])
      flash.now[:danger] = 'アニメの登録に失敗しました。'
      render "animes/new"
    end
  end

  def destroy
    @anime.destroy
    flash[:success] = 'アニメを削除しました。'
    redirect_back(fallback_location: root_path)
  end
  
  private
  
  def anime_params
    params.require(:anime).permit(:title)
  end
  
  def correct_user
    @anime = current_user.animes.find_by(id: params[:id])
    unless @anime
      redirect_to root_url
    end
  end
end
