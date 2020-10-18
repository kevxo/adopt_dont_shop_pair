class Pet < ApplicationRecord
  belongs_to :shelter
  has_many :pet_applications
  has_many :applications, through: :pet_applications

  validates_presence_of :name

  def self.pet_search(name)
    if name
      Pet.where("lower(name) like ?", "%#{name.downcase}%")
    end
  end

end
