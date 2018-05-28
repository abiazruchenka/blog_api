Rails.application.routes.draw do
  post 'blog_posts/create_post'
  post 'post_ratings/put_rating'
  post 'post_ratings/top_ratings'
  post 'blog_posts/users_address_ip_list'
end
