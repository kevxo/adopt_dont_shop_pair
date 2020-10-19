class Application < ApplicationRecord
  validates_presence_of :user_name
  belongs_to :user
  has_many :pet_applications
  has_many :pets, through: :pet_applications
  after_initialize :default_status, :default_address

  def pet_names_ids
    #MVC
    pet_names = self.pet_names.split(',')

    #Pluck?
    pet_names.map do |pet|
      name = pet.strip
      if Pet.find_by(name: name)
        Pet.find_by(name: name).id
      end
    end
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
      #MVC
      self.address ||= "#{user.street_address}, #{user.city}, #{user.state} #{user.zip}"
    end
  end

  def application_pet_count
    self.pets.count
  end

  def pet_application_status(pet_id)
    PetApplication.find_by(pet_id: pet_id, application_id: self.id).application_status
  end

end
