require 'rails_helper'

describe Pet do
  describe 'relationships' do
    it { should belong_to :shelter }
    it { should have_many :pet_applications }
    it { should have_many(:applications).through(:pet_applications) }
  end

  describe 'validations' do
    it { should validate_presence_of :name }
  end

  describe 'class methods' do
    it 'self.pet_search' do
      shelter_1 = Shelter.create!(name: 'Mile High Adoptive Services', address: '500 w first st', city: 'Centennial', state: 'CO', zip: '80022')
      shelter_2 = Shelter.create!(name: 'Colorado Cares', address: '867 magnolia st', city: 'Lakewood', state: 'CO', zip: '80022')

      pet_1 = shelter_1.pets.create!(img: 'https://dogtime.com/assets/uploads/gallery/austalian-shepherd-dog-breed-pictures/10-threequarters.jpg',
                                     name: 'Tony',
                                     approximate_age: '2',
                                     sex: 'male',
                                     description: 'Tony is a wild cracker at times, but is able to calm down and cuddle when needed.')
      pet_2 = shelter_1.pets.create!(img: 'https://dogtime.com/assets/uploads/gallery/german-shorthaired-pointer-dogs-and-puppies/german-shorthaired-pointer-dogs-puppies-3.jpg',
                                     name: 'Ms. Snowballs',
                                     approximate_age: '5',
                                     sex: 'female',
                                     description: "Ms. Snowballs is my favorite and I don't want her to go...but then again, I do!")
      pet_3 = shelter_2.pets.create!(img: 'https://dogtime.com/assets/uploads/gallery/akita-dogs-and-puppies/akita-dogs-puppies-2.jpg',
                                     name: 'Snowball',
                                     approximate_age: '1',
                                     sex: 'female',
                                     description: 'Just the cutest.')

      expect(Pet.pet_search(pet_3.name)).to include(pet_2)
      expect(Pet.pet_search(pet_3.name.upcase)).to include(pet_2)
      expect(Pet.pet_search(pet_3.name)).to include(pet_3)
      expect(Pet.pet_search(pet_3.name.downcase)).to include(pet_3)
      expect(Pet.pet_search(pet_3.name)).to_not include(pet_1)
      expect(Pet.pet_search(pet_3.name.upcase)).to_not include(pet_1)
    end
  end

  describe '.instance methods' do
    it '.deafult_status' do
      shelter_1 = Shelter.create!(name: 'Mile High Adoptive Services', address: '500 w first st', city: 'Centennial', state: 'CO', zip: '80022')
      pet_1 = shelter_1.pets.create!(img: 'https://dogtime.com/assets/uploads/gallery/austalian-shepherd-dog-breed-pictures/10-threequarters.jpg',
                                     name: 'Tony',
                                     approximate_age: '2',
                                     sex: 'male',
                                     description: 'Tony is a wild cracker at times, but is able to calm down and cuddle when needed.')

      expect(pet_1.adoptable).to eq('Yes')
    end

    it 'adoptable?' do
      user = User.create!(name: 'Bob',
                          street_address: '1234 Test Dr',
                          city: 'Denver',
                          state: 'Colorado',
                          zip: '12345')
      user_2 = User.create!(name: 'Jeff Daniels',
                            street_address: '455 west dr',
                            city: 'Denver',
                            state: 'Colorado',
                            zip: '87709')

      shelter_1 = Shelter.create!(name: 'Rocky Mountain High', address: '1234 fake st.', city: 'Denver', state: 'CO', zip: '45505')

      pet1 = Pet.create!(img: 'https://upload.wikimedia.org/wikipedia/commons/a/a3/June_odd-eyed-cat.jpg',
                         name: 'Mittens',
                         approximate_age: '6 years',
                         sex: 'Male',
                         shelter_id: shelter_1.id)

      pet2 = Pet.create(img: 'https://upload.wikimedia.org/wikipedia/commons/3/38/Adorable-animal-cat-20787.jpg',
                        name: 'Tiger',
                        approximate_age: '4 years',
                        sex: 'Male',
                        shelter_id: shelter_1.id,
                        adoptable: 'No')

      pet3 = shelter_1.pets.create!(img: 'https://dogtime.com/assets/uploads/gallery/akita-dogs-and-puppies/akita-dogs-puppies-2.jpg',
                                    name: 'Snowball',
                                    approximate_age: '1',
                                    sex: 'female',
                                    description: 'Just the cutest.')

      application_1 = Application.create!(user_name: user.name, user_id: user.id, application_status: 'Approved')
      application_2 = Application.create!(user_name: user_2.name, user_id: user_2.id, application_status: 'Pending')

      PetApplication.create!(pet_id: pet1.id, application_id: application_1.id)
      PetApplication.create!(pet_id: pet2.id, application_id: application_1.id)
      PetApplication.create!(pet_id: pet2.id, application_id: application_2.id)
      PetApplication.create!(pet_id: pet3.id, application_id: application_2.id)

      expect(pet2.adoptable?).to eq(false)
    end

    it '.cant_delete_pet' do
      user = User.create!(name: 'Bob',
                          street_address: '1234 Test Dr',
                          city: 'Denver',
                          state: 'Colorado',
                          zip: '12345')
      user2 = User.create!(name: 'Jeff Daniels',
                           street_address: '455 west dr',
                           city: 'Denver',
                           state: 'Colorado',
                           zip: '87709')

      shelter1 = Shelter.create!(name: 'Dogs and Cats',
                                 address: '1234 spoon.st',
                                 city: 'Tampa',
                                 state: 'Florida',
                                 zip: '34638')

      shelter_2 = Shelter.create!(name: 'Colorado Cares', address: '867 magnolia st', city: 'Lakewood', state: 'CO', zip: '80022')

      pet_1 = Pet.create!(img: 'https://upload.wikimedia.org/wikipedia/commons/a/a3/June_odd-eyed-cat.jpg',
                          name: 'Mittens',
                          approximate_age: '6 years',
                          sex: 'Male',
                          shelter_id: shelter1.id)

      pet_2 = Pet.create!(img: 'https://upload.wikimedia.org/wikipedia/commons/3/38/Adorable-animal-cat-20787.jpg',
                          name: 'Tiger',
                          approximate_age: '4 years',
                          sex: 'Male',
                          adoptable: 'No',
                          shelter_id: shelter1.id)

      pet_3 = shelter_2.pets.create!(img: 'https://dogtime.com/assets/uploads/gallery/akita-dogs-and-puppies/akita-dogs-puppies-2.jpg',
                                     name: 'Snowball',
                                     approximate_age: '1',
                                     sex: 'female',
                                     description: 'Just the cutest.')

      pet_4 = shelter_2.pets.create!(img: 'https://dogtime.com/assets/uploads/gallery/golden-retriever-dogs-and-puppies/golden-retriever-dogs-puppies-10.jpg',
                                     name: 'Watson',
                                     approximate_age: '3',
                                     sex: 'male',
                                     description: 'He may look dumb, and he is.')

      application_1 = Application.create!(user_name: user.name, user_id: user.id, application_status: 'Pending')
      application_2 = Application.create!(user_name: user2.name, user_id: user2.id, application_status: 'Pending')

      pet_app_1 = PetApplication.create!(pet_id: pet_1.id, application_id: application_1.id, application_status: 'Approved')
      pet_app_2 = PetApplication.create!(pet_id: pet_2.id, application_id: application_1.id, application_status: 'Approved')
      pet_app_3 = PetApplication.create!(pet_id: pet_3.id, application_id: application_2.id, application_status: 'Rejected')
      pet_app_4 = PetApplication.create!(pet_id: pet_4.id, application_id: application_2.id, application_status: 'Pending')

      expect(pet_1.cant_delete_pet?).to eq(true)
      expect(pet_2.cant_delete_pet?).to eq(true)
      expect(pet_3.cant_delete_pet?).to eq(false)
      expect(pet_4.cant_delete_pet?).to eq(false)
    end
  end
end
