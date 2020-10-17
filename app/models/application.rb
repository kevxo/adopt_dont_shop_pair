class Application < ApplicationRecord
  validates_presence_of :user_name, :address, :description, :pet_names
  belongs_to :user
  has_many :pet_applications
  has_many :pets, through: :pet_applications

  def pet_names_ids
    pet_names = self.pet_names.split(',')

    pet_names.map do |pet|
      name = pet.strip
      if Pet.find_by(name: name)
        Pet.find_by(name: name).id
      end
    end
  end
end
