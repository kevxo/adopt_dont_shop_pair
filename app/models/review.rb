class Review < ApplicationRecord
  belongs_to :user
  belongs_to :shelter
  validates_presence_of :name
  validates_presence_of :title
  validates_presence_of :content
  validates_presence_of :rating
end