class PostRatingsController < ApplicationController

  def put_rating
    average_rating = PostRatingServices.new(params)
    message, status = BlogProcessorServices.check_error(average_rating) do
      average_rating.middle_rating
    end
    render json: message, status: status
  end

  def top_ratings
    top_ratings = PostRatingServices.top_posts_rating(params)
    render json: top_ratings
  end
end
