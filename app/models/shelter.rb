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

  def cant_delete?
    dont_delete = nil
    pets.each do |pet|
      pet_application = PetApplication.find_by pet_id: pet.id
      application = Application.find_by(id: pet_application.application_id)
      if PetApplication.all_approved?(application.id)
        dont_delete = true
      else
        dont_delete = false
      end
    end
    dont_delete
  end
end