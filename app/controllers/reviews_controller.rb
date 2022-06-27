class ReviewsController < ApplicationController
  def create
    @user = User.find(params[:user_id])
    @review = Review.new(review_params)
    @review.student_id = current_user.id
    @review.user = @user
    if @review.save
      redirect_to user_path(@user, anchor: "review-#{@review.id}")
    else
      render 'users/show'
    end
  end

  private

  def review_params
    params.require(:review).permit(:content, :rating, :user_id)
  end
end
