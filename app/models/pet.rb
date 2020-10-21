class Pet < ApplicationRecord
  belongs_to :shelter
  has_many :pet_applications, dependent: :destroy
  has_many :applications, through: :pet_applications, dependent: :destroy

  validates_presence_of :name
  after_initialize :default_status

  def self.pet_search(name)
    if name
      Pet.where("lower(name) like ?", "%#{name.downcase}%")
    end
  end

  def default_status
    self.adoptable ||= 'Yes'
  end

  def adoptable?
    self.adoptable == "Yes"
  end

  def deletable?
    self.applications.none? do |application|
      application.application_status == "Approved"
    end
  end
end
