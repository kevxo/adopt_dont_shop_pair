class Application < ApplicationRecord
  validates_presence_of :user_name
  belongs_to :user
  has_many :pet_applications
  has_many :pets, through: :pet_applications
  after_initialize :default_status, :default_address

  def pet_names_ids
    pet_names = self.pet_names.split(',')

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

  def default_address
    if self.user_id
      user = User.find(self.user_id)
      self.address ||= "#{user.street_address}, #{user.city}, #{user.state} #{user.zip}"
    end 
  end

  def application_pet_count
    self.pets.count
  end

end
