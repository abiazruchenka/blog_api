class AddMiddleRatingToBlogPost < ActiveRecord::Migration[5.1]
  def change
    add_column :blog_posts, :middle_rating, :integer, limit: 1
    add_index :blog_posts, :middle_rating
  end
end
