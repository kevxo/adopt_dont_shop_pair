require 'rails_helper'

RSpec.describe PetApplication, type: :model do
  describe "relationships" do
    it { should belong_to :application}
    it { should belong_to :pet}
  end

  describe "instance methods" do
    it "default_status" do
      user = User.create!(name: 'Bob',
                          street_address: '1234 Test Dr',
                          city: 'Denver',
                          state: 'Colorado',
                          zip: '12345')
                          
      shelter1 = Shelter.create!(name: 'Dogs and Cats',
                                 address: '1234 spoon.st',
                                 city: 'Tampa',
                                 state: 'Florida',
                                 zip: '34638')
      pet1 = Pet.create!(img: 'https://upload.wikimedia.org/wikipedia/commons/a/a3/June_odd-eyed-cat.jpg',
                         name: 'Mittens',
                         approximate_age: '6 years',
                         sex: 'Male',
                         shelter_id: shelter1.id)

      pet2 = Pet.create!(img: 'https://upload.wikimedia.org/wikipedia/commons/3/38/Adorable-animal-cat-20787.jpg',
                         name: 'Tiger',
                         approximate_age: '4 years',
                         sex: 'Male',
                         shelter_id: shelter1.id)

      application_1 = Application.create!(user_name: user.name, user_id: user.id)

      pet_application_1 = PetApplication.create!(pet_id: pet1.id, application_id: application_1.id)
      pet_application_2 = PetApplication.create!(pet_id: pet2.id, application_id: application_1.id)

      expect(pet_application_1.application_status).to eq("Pending")
      expect(pet_application_2.application_status).to eq("Pending")
    end
  end
end
