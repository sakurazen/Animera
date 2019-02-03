class ReviewsController < ApplicationController
  before_action :require_user_logged_in
  before_action :correct_user, only: [:index, :destroy]
  
  def index
    @reviews = Review.all.page(params[:page])
  end
  
  def show
    @review = Review.find(params[:id])
  end

  def new
    @anime = Anime.find(params[:anime_id])
    @review = @anime.reviews.build
  end

  def create
    @review = current_user.reviews.build(review_params) 
    if @review.save
      flash[:success] = '評価を登録しました。'
      redirect_to @review.anime
    else
      @reviews = current_user.reviews.order('created_at DESC').page(params[:page])
      flash.now[:danger] = '評価の登録に失敗しました。'
      render 'reviews/new'
    end
  end

  def destroy
    @review.destroy
    flash[:success] = 'レビューを削除しました。'
    redirect_back(fallback_location: root_path)
  end

  def update
    @review = Review.find(params[:id])
    if @review.update(review_params)
      flash[:success] = '評価は正常に更新されました'
      redirect_to @review.anime
    else
      flash.now[:danger] = '評価は更新されませんでした'
      render :show
    end
  end
  
  private
  
  def review_params
    params.require(:review).permit(:anime_id, :episode_no, :episode_score, :comment)
  end
  
  def correct_user
    @review = current_user.reviews.find_by(id: params[:id])
    unless @review
      redirect_to root_url
    end
  end
end
