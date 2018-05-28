class PostRatingServices
  include ActiveModel::Validations
  attr_accessor :blog_post_id, :rating

  validates :blog_post_id, presence: true, numericality: { only_integer: true }
  validates :rating, numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 5 }

   BLOG_POSTS_LIMIT = 10

  def initialize(params)
    @blog_post_id = params[:blog_post_id]
    @rating = params[:rating]
  end

  def save
    Rating.create(blog_post_id: blog_post_id, rating: rating)
  end

  def middle_rating
    ratings = Rating.where(blog_post_id: blog_post_id).pluck(:rating)
    middle_rating = mid_rating_calculating(ratings)
    blog_post = BlogPost.find(blog_post_id)
    blog_post.update(middle_rating: middle_rating.to_i)
    {rating: middle_rating}
  end

  def self.top_posts_rating(params)
    BlogPost.select(:id, :title, :message).order(middle_rating: :desc).limit(params[:simple_n])
  end

  private

  def mid_rating_calculating(ratings)
    ratings.sum / ratings.count if ratings.count.nonzero?
  end
end

