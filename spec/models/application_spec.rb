require 'rails_helper'

RSpec.describe Application, type: :model do
  describe 'relationships' do
    it { should belong_to :user }
    it { should have_many :pet_applications }
    it { should have_many(:pets).through(:pet_applications) }
  end

  describe 'validations' do
    it { should validate_presence_of :user_name }
    it { should validate_presence_of :address }
    it { should validate_presence_of :description }
    it { should validate_presence_of :pet_names }
  end

  describe 'instance methods' do
    it '.pet_names_ids' do
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

      application_1 = Application.create!(user_name: user.name, address: "#{user.street_address}, #{user.city}, #{user.state} #{user.zip}",
                                          description: 'I am an experienced pet owner for 5 years and I just love this pet!',
                                          pet_names: "#{pet1.name},#{pet2.name}", user_id: user.id)

      expect(application_1.pet_names_ids).to eq([pet1.id, pet2.id])
    end

    it 'init' do
      shelter_1 = Shelter.create!(name: "Mile High Adoptive Services", address: "500 w first st", city: "Centennial", state: "CO", zip: "80022")

      pet_1 = shelter_1.pets.create!(img: "https://dogtime.com/assets/uploads/gallery/austalian-shepherd-dog-breed-pictures/10-threequarters.jpg",
                        name: "Tony",
                        approximate_age: "2",
                        sex: "male",
                        description: "Tony is a wild cracker at times, but is able to calm down and cuddle when needed.")

      user_1 = User.create!(name: 'Holly Baker',
                          street_address: '4443 fountain ave',
                          city: 'Lakewood',
                          state: 'CO',
                          zip: '80009')

      application_1 = Application.create!(user_name: user_1.name, address: "#{user_1.street_address}, #{user_1.city}, #{user_1.state} #{user_1.zip}",
                                        description: "I am an experienced pet owner for 5 years and I just love this pet!",
                                        pet_names: "#{pet_1.name}", user_id: user_1.id)

      PetApplication.create!(pet_id: pet_1.id, application_id: application_1.id)

      expect(application_1.application_status).to eq("In Progress")
    end
  end
end
