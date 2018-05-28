class CreateRatings < ActiveRecord::Migration[5.1]
  def change
    create_table :ratings do |t|
      t.references :blog_post, foreign_key: true
      t.integer :rating,  limit: 1, null: false

      t.timestamps
    end

    add_index :ratings, :id
  end
end
