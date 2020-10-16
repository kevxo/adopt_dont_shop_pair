class User < ApplicationRecord
  has_many :reviews

  validates_presence_of :name

  def average_rating
    reviews.average(:rating)
  end

  def best_rating_review
    reviews.order(rating: :desc).first
  end

  def worst_rating_review
    reviews.order(:rating).first
  end
end
