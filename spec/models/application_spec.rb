require 'rails_helper'

RSpec.describe Application, type: :model do
  describe 'relationships' do
    it { should belong_to :user }
    it { should have_many :pet_applications }
    it { should have_many(:pets).through(:pet_applications) }
  end

  describe 'validations' do
    it { should validate_presence_of :user_name }
  end

  describe 'instance methods' do
    # it '.pet_names_ids' do
    #   user = User.create!(name: 'Bob',
    #                       street_address: '1234 Test Dr',
    #                       city: 'Denver',
    #                       state: 'Colorado',
    #                       zip: '12345')
    #   shelter1 = Shelter.create!(name: 'Dogs and Cats',
    #                              address: '1234 spoon.st',
    #                              city: 'Tampa',
    #                              state: 'Florida',
    #                              zip: '34638')
    #
    #   pet1 = Pet.create!(img: 'https://upload.wikimedia.org/wikipedia/commons/a/a3/June_odd-eyed-cat.jpg',
    #                      name: 'Mittens',
    #                      approximate_age: '6 years',
    #                      sex: 'Male',
    #                      shelter_id: shelter1.id)
    #
    #   pet2 = Pet.create!(img: 'https://upload.wikimedia.org/wikipedia/commons/3/38/Adorable-animal-cat-20787.jpg',
    #                      name: 'Tiger',
    #                      approximate_age: '4 years',
    #                      sex: 'Male',
    #                      shelter_id: shelter1.id)
    #
    #   application_1 = Application.create!(user_name: user.name, address: "#{user.street_address}, #{user.city}, #{user.state} #{user.zip}",
    #                                       description: 'I am an experienced pet owner for 5 years and I just love this pet!',
    #                                       pet_names: "#{pet1.name},#{pet2.name}", user_id: user.id)
    #
    #   expect(application_1.pet_names_ids).to eq([pet1.id, pet2.id])
    # end

    it 'default_status' do
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

    it 'pet_count' do
      shelter_1 = Shelter.create!(name: "Mile High Adoptive Services", address: "500 w first st", city: "Centennial", state: "CO", zip: "80022")

      pet_1 = shelter_1.pets.create!(img: "https://dogtime.com/assets/uploads/gallery/austalian-shepherd-dog-breed-pictures/10-threequarters.jpg",
                        name: "Tony",
                        approximate_age: "2",
                        sex: "male",
                        description: "Tony is a wild cracker at times, but is able to calm down and cuddle when needed.")
      pet_2 = shelter_1.pets.create!(img: "https://dogtime.com/assets/uploads/gallery/akita-dogs-and-puppies/akita-dogs-puppies-2.jpg",
                                    name: "Snowball",
                                    approximate_age: "1",
                                    sex: "female",
                                    description: "Just the cutest.")
      user_1 = User.create!(name: 'Holly Baker',
                          street_address: '4443 fountain ave',
                          city: 'Lakewood',
                          state: 'CO',
                          zip: '80009')

      application_1 = Application.create!(user_name: user_1.name, address: "#{user_1.street_address}, #{user_1.city}, #{user_1.state} #{user_1.zip}",
                                        description: "I am an experienced pet owner for 5 years and I just love this pet!",
                                        pet_names: "#{pet_1.name}", user_id: user_1.id)

      PetApplication.create!(pet_id: pet_1.id, application_id: application_1.id)

      expect(application_1.application_pet_count).to eq(1)

      PetApplication.create!(pet_id: pet_2.id, application_id: application_1.id)

      expect(application_1.application_pet_count).to eq(2)
    end

    it 'default_address' do
      user_1 = User.create!(name: 'Holly Baker',
                          street_address: '4443 fountain ave',
                          city: 'Lakewood',
                          state: 'CO',
                          zip: '80009')

      application_1 = Application.create!(user_name: user_1.name, user_id: user_1.id)

      expect(application_1.address).to eq("#{user_1.street_address}, #{user_1.city}, #{user_1.state} #{user_1.zip}")
    end

    it 'pet_application_status' do
      shelter_1 = Shelter.create!(name: "Mile High Adoptive Services", address: "500 w first st", city: "Centennial", state: "CO", zip: "80022")

      pet_1 = shelter_1.pets.create!(img: "https://dogtime.com/assets/uploads/gallery/austalian-shepherd-dog-breed-pictures/10-threequarters.jpg",
                        name: "Tony",
                        approximate_age: "2",
                        sex: "male",
                        description: "Tony is a wild cracker at times, but is able to calm down and cuddle when needed.")
      pet_2 = shelter_1.pets.create!(img: "https://dogtime.com/assets/uploads/gallery/akita-dogs-and-puppies/akita-dogs-puppies-2.jpg",
                                    name: "Snowball",
                                    approximate_age: "1",
                                    sex: "female",
                                    description: "Just the cutest.")
      user_1 = User.create!(name: 'Holly Baker',
                          street_address: '4443 fountain ave',
                          city: 'Lakewood',
                          state: 'CO',
                          zip: '80009')

      application_1 = Application.create!(user_name: user_1.name, address: "#{user_1.street_address}, #{user_1.city}, #{user_1.state} #{user_1.zip}",
                                        description: "I am an experienced pet owner for 5 years and I just love this pet!",
                                        pet_names: "#{pet_1.name}", user_id: user_1.id)

      PetApplication.create!(pet_id: pet_1.id, application_id: application_1.id)
      PetApplication.create!(pet_id: pet_2.id, application_id: application_1.id, application_status: "Approved")

      expect(application_1.pet_application_status(pet_1.id)).to eq("Pending")
      expect(application_1.pet_application_status(pet_2.id)).to eq("Approved")
    end

    it 'add_pet_name(name)' do
      shelter_1 = Shelter.create!(name: 'Mile High Adoptive Services', address: '500 w first st', city: 'Centennial', state: 'CO', zip: '80022')

      pet_1 = shelter_1.pets.create!(img: 'https://dogtime.com/assets/uploads/gallery/austalian-shepherd-dog-breed-pictures/10-threequarters.jpg',
                                     name: 'Tony',
                                     approximate_age: '2',
                                     sex: 'male',
                                     description: 'Tony is a wild cracker at times, but is able to calm down and cuddle when needed.')

      pet_2 = shelter_1.pets.create!(img: 'https://dogtime.com/assets/uploads/gallery/akita-dogs-and-puppies/akita-dogs-puppies-2.jpg',
                                      name: 'Regina',
                                      approximate_age: '1',
                                      sex: 'female',
                                      description: 'Just the cutest.')
      user_1 = User.create!(name: 'Holly Baker',
                            street_address: '4443 fountain ave',
                            city: 'Lakewood',
                            state: 'CO',
                            zip: '80009')

      application_1 = Application.create!(user_name: user_1.name, user_id: user_1.id)

      expect(application_1.add_pet_name(pet_1.name)).to eq("#{pet_1.name}")
      expect(application_1.add_pet_name(pet_2.name)).to eq("#{pet_1.name}, #{pet_2.name}")
    end

    it 'unique_pet?' do
      shelter_1 = Shelter.create!(name: 'Mile High Adoptive Services', address: '500 w first st', city: 'Centennial', state: 'CO', zip: '80022')

      shelter_2 = Shelter.create(name: 'Pets are Us',
                                 address: '1894 Lincoln.st',
                                 city: 'Tampa',
                                 state: 'Florida',
                                 zip: '32938')

      user_1 = User.create!(name: 'Holly Baker',
                             street_address: '4443 fountain ave',
                             city: 'Lakewood',
                             state: 'CO',
                             zip: '80009')
      pet_1 = shelter_1.pets.create!(img: 'https://dogtime.com/assets/uploads/gallery/austalian-shepherd-dog-breed-pictures/10-threequarters.jpg',
                                     name: 'Tony',
                                     approximate_age: '2',
                                     sex: 'male',
                                     description: 'Tony is a wild cracker at times, but is able to calm down and cuddle when needed.')

      pet_2 = shelter_1.pets.create!(img: 'https://dogtime.com/assets/uploads/gallery/akita-dogs-and-puppies/akita-dogs-puppies-2.jpg',
                                      name: 'Regina',
                                      approximate_age: '1',
                                      sex: 'female',
                                      description: 'Just the cutest.')

      pet_3 = shelter_2.pets.create!(img: 'https://dogtime.com/assets/uploads/gallery/austalian-shepherd-dog-breed-pictures/10-threequarters.jpg',
                                     name: 'Tony',
                                     approximate_age: '2',
                                     sex: 'male',
                                     description: 'Tony is a wild cracker at times, but is able to calm down and cuddle when needed.')

      application_1 = Application.create!(user_name: user_1.name, user_id: user_1.id, pet_names: pet_1.name)

      PetApplication.create!(pet_id: pet_1.id, application_id: application_1.id)

      expect(application_1.unique_pet?(pet_2.name)).to eq(true)
      expect(application_1.unique_pet?(pet_3.name)).to eq(false)
    end

  end
end
