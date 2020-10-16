class Application < ApplicationRecord
  validates_presence_of :user_name, :address, :description, :pet_names
  belongs_to :user
  has_many :pet_applications
  has_many :pets, through: :pet_applications
end
