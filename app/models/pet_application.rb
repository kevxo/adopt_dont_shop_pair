class PetApplication < ApplicationRecord
  belongs_to :application
  belongs_to :pet
  after_initialize :default_status

  def default_status
    self.application_status ||= "Pending"
  end
end
