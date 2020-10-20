class PetApplication < ApplicationRecord
  belongs_to :application
  belongs_to :pet
  after_initialize :default_status

  def default_status
    self.application_status ||= "Pending"
  end

  def self.all_approved?(application_id)
    application_pets = self.where(application_id: application_id)
    application_pets.all? do |pet_application|
      pet_application.application_status == "Approved"
    end
  end

  def self.any_pending?(application_id)
    application_pets = self.where(application_id: application_id)
    application_pets.any? do |pet_application|
      pet_application.application_status == "Pending"
    end
  end

end
