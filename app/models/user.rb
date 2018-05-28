class User < ApplicationRecord
  has_many :blog_posts, dependent: :destroy
  has_many :login_ips, dependent: :destroy
end
