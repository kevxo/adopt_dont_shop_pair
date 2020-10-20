require 'rails_helper'

describe 'As a visitor' do
  describe "When I visit '/pets'" do
    it 'should display each Pet in the system' do
      shelter1 = Shelter.create(name: 'Dogs and Cats',
                                address: '1234 spoon.st',
                                city: 'Tampa',
                                state: 'Florida',
                                zip: '34638')
      pet1 = Pet.create(img: 'https://upload.wikimedia.org/wikipedia/commons/a/a3/June_odd-eyed-cat.jpg',
                        name: 'Mittens',
                        approximate_age: '6 years',
                        sex: 'Male',
                        shelter_id: shelter1.id)

      pet2 = Pet.create(img: 'https://upload.wikimedia.org/wikipedia/commons/3/38/Adorable-animal-cat-20787.jpg',
                        name: 'Tiger',
                        approximate_age: '4 years',
                        sex: 'Male',
                        shelter_id: shelter1.id)

      visit '/pets'

      expect(page).to have_content('All Pets')
      expect(page).to have_xpath("//img[contains(@src,'#{pet1.img}')]")
      expect(page).to have_xpath("//img[contains(@src,'#{pet2.img}')]")
      expect(page).to have_content(pet1.name)
      expect(page).to have_content(pet2.name)
      expect(page).to have_content(pet1.approximate_age)
      expect(page).to have_content(pet2.approximate_age)
      expect(page).to have_content(pet1.sex)
      expect(page).to have_content(pet2.sex)
      expect(page).to have_content(pet1.shelter_id)
      expect(page).to have_content(pet2.shelter_id)
    end
  end
end

describe 'As a visitor' do
  describe "When I visit '/shelters/:shelter_id/pets'" do
    it 'should see each Pet that can be adopted from that Shelter with its
    shelter_id and its info' do
      shelter1 = Shelter.create(name: 'Dogs and Cats',
                                address: '1234 spoon.st',
                                city: 'Tampa',
                                state: 'Florida',
                                zip: '34638')
      pet1 = Pet.create(img: 'https://upload.wikimedia.org/wikipedia/commons/a/a3/June_odd-eyed-cat.jpg',
                        name: 'Mittens',
                        approximate_age: '6 years',
                        sex: 'Male',
                        shelter_id: shelter1.id)

      visit "/shelters/#{shelter1.id}/pets"

      expect(page).to have_content('All Pets')
      expect(page).to have_xpath("//img[contains(@src,'#{pet1.img}')]")
      expect(page).to have_content(pet1.name)
      expect(page).to have_content(pet1.approximate_age)
      expect(page).to have_content(pet1.sex)
    end
  end
end

describe 'As a visitor' do
  describe 'When I visit a Shelter Pets Index page' do
    it "should have a link to add a new adoptable pet for that shelter 'Create Pet'" do
      shelter1 = Shelter.create(name: 'Dogs and Cats',
                                address: '1234 spoon.st',
                                city: 'Tampa',
                                state: 'Florida',
                                zip: '34638')
      pet1 = Pet.create(img: 'https://upload.wikimedia.org/wikipedia/commons/a/a3/June_odd-eyed-cat.jpg',
                        name: 'Mittens',
                        approximate_age: '6 years',
                        sex: 'Male',
                        shelter_id: shelter1.id)

      visit "/shelters/#{shelter1.id}/pets"

      expect(page).to have_link('Create Pet')

      visit "/shelters/#{shelter1.id}/pets"
      click_link 'Create Pet'

      expect(current_path).to eq("/shelters/#{shelter1.id}/pets/new")
    end
  end
end

describe 'As a visitor' do
  describe 'When I visit the pets index or shelter pets index' do
    it 'should have a link where I click and can update the pets info' do
      shelter1 = Shelter.create(name: 'Dogs and Cats',
                                address: '1234 spoon.st',
                                city: 'Tampa',
                                state: 'Florida',
                                zip: '34638')
      pet1 = Pet.create(img: 'https://upload.wikimedia.org/wikipedia/commons/a/a3/June_odd-eyed-cat.jpg',
                        name: 'Mittens',
                        approximate_age: '6 years',
                        sex: 'Male',
                        shelter_id: shelter1.id)

      visit "/shelters/#{shelter1.id}/pets"

      expect(page).to have_link('Edit Pet')

      visit '/pets'
      expect(page).to have_link('Edit Pet')

      visit "/shelters/#{shelter1.id}/pets"
      visit '/pets'

      within "#pet-#{pet1.id}" do
        click_link 'Edit Pet'
      end

      expect(current_path).to eq("/pets/#{pet1.id}/edit")
    end
  end
end

describe 'As a visitor' do
  describe 'When I visit the pets index or a shelter pets index page' do
    it 'I should see a button to delete tha pet. When I click I should not see the pet' do
      shelter1 = Shelter.create(name: 'Dogs and Cats',
                                address: '1234 spoon.st',
                                city: 'Tampa',
                                state: 'Florida',
                                zip: '34638')
      pet1 = Pet.create(img: 'https://upload.wikimedia.org/wikipedia/commons/a/a3/June_odd-eyed-cat.jpg',
                        name: 'Mittens',
                        approximate_age: '6 years',
                        sex: 'Male',
                        shelter_id: shelter1.id)

      visit "/shelters/#{shelter1.id}/pets"

      expect(page).to have_button('Delete Pet')

      visit '/pets'
      expect(page).to have_button('Delete Pet')

      visit "/shelters/#{shelter1.id}/pets"
      visit '/pets'

      within "#pet-#{pet1.id}" do
        click_button 'Delete Pet'
      end

      expect(current_path).to eq('/pets')
    end
  end
end

describe 'As a visitor' do
  describe 'When I click on the name of a pet anywhere on the site' do
    it 'the link should take me to the show page' do
      shelter1 = Shelter.create(name: 'Dogs and Cats',
                                address: '1234 spoon.st',
                                city: 'Tampa',
                                state: 'Florida',
                                zip: '34638')
      pet1 = Pet.create(img: 'https://upload.wikimedia.org/wikipedia/commons/a/a3/June_odd-eyed-cat.jpg',
                        name: 'Mittens',
                        approximate_age: '6 years',
                        sex: 'Male',
                        shelter_id: shelter1.id)

      visit "/shelters/#{shelter1.id}/pets"

      expect(page).to have_link(pet1.name.to_s)

      visit '/pets'
      expect(page).to have_link(pet1.name.to_s)

      visit "/shelters/#{shelter1.id}/pets"
      visit '/pets'
      click_link pet1.name.to_s

      expect(current_path).to eq("/pets/#{pet1.id}")
    end
  end
end

describe 'As a visitor ' do
  describe 'When I visit any page on the site' do
    it 'should see a link that takes me to shelter index page' do
      shelter1 = Shelter.create(name: 'Dogs and Cats',
                                address: '1234 spoon.st',
                                city: 'Tampa',
                                state: 'Florida',
                                zip: '34638')
      visit "/shelters/#{shelter1.id}/pets"
      expect(page).to have_link('Shelter Index')

      visit '/pets'

      expect(page).to have_link('Shelter Index')
      visit "/shelters/#{shelter1.id}/pets"
      visit '/pets'
      click_link 'Shelter Index'

      expect(current_path).to eq('/shelters')
    end
  end

  describe 'When I visit the pet index page' do
    it 'should have a link to start application' do
      shelter1 = Shelter.create!(name: 'Dogs and Cats',
                                 address: '1234 spoon.st',
                                 city: 'Tampa',
                                 state: 'Florida',
                                 zip: '34638')
      visit "/shelters/#{shelter1.id}/pets"

      expect(page).to have_link('Start an Application')

      click_link 'Start an Application'

      expect(current_path).to eq('/applications/new')
    end
  end

  describe 'If a pet has an approved application on them' do
    it 'cant delete the pet' do
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

      visit "/shelters/#{shelter1.id}/pets"

      within "#pet-delete-#{pet_1.id}" do
        expect(page).to have_button('Delete Pet')
        click_button 'Delete Pet'
      end

      expect(page).to have_content("Pet can't be deleted: Pet has an approved application.")

      within "#pet-delete-#{pet_2.id}" do
        expect(page).to have_button('Delete Pet')
        click_button 'Delete Pet'
      end

      expect(page).to have_content("Pet can't be deleted: Pet has an approved application.")

      visit "/shelters/#{shelter_2.id}/pets"
      within "#pet-delete-#{pet_3.id}" do
        expect(page).to have_button('Delete Pet')
        click_button 'Delete Pet'
      end

      expect(current_path).to eq('/pets')

      within "#pet-delete-#{pet_4.id}" do
        expect(page).to have_button('Delete Pet')
        click_button 'Delete Pet'
      end

      expect(current_path).to eq('/pets')
    end
  end
end
