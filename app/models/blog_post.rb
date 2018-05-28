class BlogPost < ApplicationRecord
  belongs_to :user
  has_many :ratings, dependent: :destroy
end
