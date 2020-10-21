class Shelter < ApplicationRecord
  has_many :pets
  has_many :reviews

  validates_presence_of :name

  def pet_count
    self.pets.count
  end

  def average_rating
    self.reviews.average(:rating)
  end

  def number_of_applications
    count = 0
    pets.each do |pet|
      if  PetApplication.find_by pet_id: pet.id
        count += 1
      end
    end
    count
  end

  def deletable?
    shelter_pets = self.pets
    applications = shelter_pets.map do |pet|
      pet.applications
    end.flatten

    applications.none? do |application|
      application.application_status == "Approved"
    end
  end
end