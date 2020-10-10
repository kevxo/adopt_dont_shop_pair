class Pet < ApplicationRecord
  has_many :shelters

  validates_presence_of :name
end