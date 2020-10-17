require 'rails_helper'

RSpec.describe Application, type: :model do
  describe 'relationships' do
    it { should belong_to :user}
    it { should have_many :pet_applications}
    it { should have_many(:pets).through(:pet_applications)}
  end

  describe 'validations' do
    it { should validate_presence_of :user_name}
    it { should validate_presence_of :address}
    it { should validate_presence_of :description}
    it { should validate_presence_of :pet_names}
  end

  describe 'instance methods' do
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

  describe "class methods" do
    it "self.pet_search" do
      shelter_1 = Shelter.create!(name: "Mile High Adoptive Services", address: "500 w first st", city: "Centennial", state: "CO", zip: "80022")
      shelter_2 = Shelter.create!(name: "Colorado Cares", address: "867 magnolia st", city: "Lakewood", state: "CO", zip: "80022")

      pet_1 = shelter_1.pets.create!(img: "https://dogtime.com/assets/uploads/gallery/austalian-shepherd-dog-breed-pictures/10-threequarters.jpg",
                        name: "Tony",
                        approximate_age: "2",
                        sex: "male",
                        description: "Tony is a wild cracker at times, but is able to calm down and cuddle when needed.")
      pet_2 = shelter_1.pets.create!(img: "https://dogtime.com/assets/uploads/gallery/german-shorthaired-pointer-dogs-and-puppies/german-shorthaired-pointer-dogs-puppies-3.jpg",
                                    name: "Ms. Snowballs",
                                    approximate_age: "5",
                                    sex: "female",
                                    description: "Ms. Snowballs is my favorite and I don't want her to go...but then again, I do!")
      pet_3 = shelter_2.pets.create!(img: "https://dogtime.com/assets/uploads/gallery/akita-dogs-and-puppies/akita-dogs-puppies-2.jpg",
                                    name: "Snowball",
                                    approximate_age: "1",
                                    sex: "female",
                                    description: "Just the cutest.")

      expect(Pet.pet_search(pet_3.name)).to include(pet_2)
      expect(Pet.pet_search(pet_3.name)).to include(pet_3)
      expect(Pet.pet_search(pet_3.name)).to_not include(pet_1)
    end
  end
end
