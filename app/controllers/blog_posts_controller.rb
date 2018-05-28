class BlogPostsController < ApplicationController

  def create_post
    blog_post = UsersPostServices.new(params)
    message, status = BlogProcessorServices.check_error(blog_post) do
      blog_post
    end
    render json: message, status: status
  end

  def users_address_ip_list
    ip_list = UsersPostServices.login_address_list
    render json: ip_list
  end

end
