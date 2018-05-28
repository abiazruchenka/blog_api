# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

include BlogProcessor

TEXT = 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor '\
       'incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud '\
       'exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure '\
       'dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. '\
       'Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit '\
       'anim id est laborum.'

(200000).times do |i|
  blog_post = UsersPost.new(title: "this one sample test title_#{i}", message: "#{i} #{TEXT}",
                login: "192.168.0.#{i % 51}", author_ip: i % 100)
  blog_post.save
  # check_error(blog_post) do
  #   blog_post
  # end

  if ((i % 3) > 1)
    rating = rand(1..5)
    rating.times do |r|
      average_rating = PostRating.new(blog_post_id: i, rating: r + 1)
      average_rating.save
      # check_error(average_rating) do
        average_rating.middle_rating
      # end
    end
  end

  puts i
end





