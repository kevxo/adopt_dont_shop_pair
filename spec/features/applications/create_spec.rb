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
      visit '/applications/new'

      fill_in "user_name", with: user_name

      click_button 'Submit'
      application = Application.last


      expect(current_path).to eq("/applications/#{application.id}")
      expect(page).to have_content('Bob')
    end
  end
end
