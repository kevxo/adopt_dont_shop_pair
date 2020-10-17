require 'rails_helper'

RSpec.describe 'As a visitor' do
  describe 'when I have been take to the new application form' do
    it 'I should see a form to fill out.' do
      user = User.create(name: 'Bob',
                          street_address: '1234 Test Dr',
                          city: 'Denver',
                          state: 'Colorado',
                          zip: '12345')
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

      user_name =  user.name
      address = "#{user.street_address}, #{user.city}, #{user.state} #{user.zip}"
      description = 'I am an experienced pet owner for 5 years and I just love this pet!'
      pet_names = "#{pet1.name}, #{pet2.name}"
      user_id = user.id

      visit '/applications/new'

      fill_in :user_name, with: user_name
      fill_in :address, with: address
      fill_in :description, with: description
      fill_in :pet_names, with: pet_names

      click_button 'Submit'
      application = Application.last


      expect(current_path).to eq("/applications/#{application.id}")

      expect(page).to have_content('Bob')
      expect(page).to have_content('1234 Test Dr, Denver, Colorado 12345')
      expect(page).to have_content('I am an experienced pet owner for 5 years and I just love this pet!')

      within "#pet-#{pet1.id}" do
        expect(page).to have_link(pet1.name)
        click_link(pet1.name)
      end

      expect(current_path).to eq("/pets/#{pet1.id}")

      visit "/applications/#{application.id}"

      within "#pet-#{pet2.id}" do
        expect(page).to have_link(pet2.name)
        click_link(pet2.name)
      end

      expect(current_path).to eq("/pets/#{pet2.id}")
    end
  end
end
