class Application < ApplicationRecord
  validates_presence_of :user_name
  belongs_to :user
  has_many :pet_applications
  has_many :pets, through: :pet_applications
  after_initialize :init

  def init
    self.application_status ||= "In Progress"
  end

  def application_pet_count
    self.pets.count
  end

end
