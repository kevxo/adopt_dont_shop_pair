require 'rails_helper'

describe Pet do
  describe 'relationships' do
    it { should belong_to :shelter }
    it { should have_many :pet_applications}
    it { should have_many(:applications).through(:pet_applications)}
  end

  describe 'validations' do
    it { should validate_presence_of :name}
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
      expect(Pet.pet_search(pet_3.name.upcase)).to include(pet_2)
      expect(Pet.pet_search(pet_3.name)).to include(pet_3)
      expect(Pet.pet_search(pet_3.name.downcase)).to include(pet_3)
      expect(Pet.pet_search(pet_3.name)).to_not include(pet_1)
      expect(Pet.pet_search(pet_3.name.upcase)).to_not include(pet_1)
    end
  end
end
