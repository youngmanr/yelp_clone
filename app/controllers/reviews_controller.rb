class ReviewsController < ApplicationController
  def new
    @restaurant = Restaurant.find(params[:restaurant_id])
    @review = Review.new
  end

  def create
    @restaurant = Restaurant.find(params[:restaurant_id])
    @review = @restaurant.reviews.create(review_params)
    if @review.save
      redirect_to restaurants_path
    else
      flash[:notice] = @review.errors.first[1] #error from the review model
      redirect_to restaurants_path
    end
  end

  
  def build_review(attributes = {}, user)
    attributes[:user] ||= user
    reviews.build(attributes)
  end


  def review_params
    params.require(:review).permit(:thoughts, :rating)
  end
end
