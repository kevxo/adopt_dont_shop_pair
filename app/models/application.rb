class Application < ApplicationRecord
  validates_presence_of :user_name
  belongs_to :user
  has_many :pet_applications
  has_many :pets, through: :pet_applications
  after_initialize :default_status, :default_address

  def unique_pet?(name)
    !self.pet_names.include?(name)
  end

  def default_status
    self.application_status ||= "In Progress"
  end

  def add_pet_name(name)
    if self.pet_names
      self.pet_names << ", #{name}"
    else
      self.pet_names = name
    end
  end

  def default_address
    if self.user_id
      user = User.find(self.user_id)
      self.address ||= "#{user.street_address}, #{user.city}, #{user.state} #{user.zip}"
    end
  end

  def application_pet_count
    self.pets.count
  end

  def pet_application_status(pet_id)
    PetApplication.find_by(pet_id: pet_id, application_id: self.id).application_status
  end

  def adopt_pets
    self.pets.each do |pet|
      pet.update(adoptable: "No")
      Application.reject_outstanding_applications(self, pet.applications)
    end
  end

  def self.reject_outstanding_applications(approved_app, all_apps)
    all_apps.each do |app|
      if app.id != approved_app.id
        app.update(application_status: "Rejected")
      end
    end
  end


end
