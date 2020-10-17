class Pet < ApplicationRecord
  belongs_to :shelter
  has_many :pet_applications
  has_many :applications, through: :pet_applications

  validates_presence_of :name

  def self.pet_search(name)
    Pet.where("name like ?", "%#{name}%")
  end

end
