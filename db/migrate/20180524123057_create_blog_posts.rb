class CreateBlogPosts < ActiveRecord::Migration[5.1]
  def change
    create_table :blog_posts do |t|
      t.string :title,  limit: 64, null: false
      t.text :message, null: false
      t.references :user, foreign_key: true
      t.string :author_ip, null: false

      t.timestamps
    end

    add_index :blog_posts, [:author_ip, :user_id]
  end
end
