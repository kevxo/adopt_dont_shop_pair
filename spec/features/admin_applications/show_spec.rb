require 'rails_helper'

RSpec.describe 'As a visitor' do
  describe "when I visit an admin application show page '/admin/applications/:id'" do
    it "I should see a button to approve a pets application for every pet" do
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
                         adoptable: 'No',
                         shelter_id: shelter1.id)

      application_1 = Application.create!(user_name: user.name, user_id: user.id)

      PetApplication.create!(pet_id: pet1.id, application_id: application_1.id)
      PetApplication.create!(pet_id: pet2.id, application_id: application_1.id)

      visit "/admin/applications/#{application_1.id}"

      within "#pet-#{pet1.id}-application" do
        expect(page).to have_content(pet1.name)
        expect(page).to have_button("Approve Pet")
        expect(page).to_not have_content("Approved")
        click_button("Approve Pet")
      end
      save_and_open_page
      expect(current_path).to eq("/admin/applications/#{application_1.id}")

      within "#pet-#{pet1.id}-application" do
        expect(page).to have_content(pet1.name)
        expect(page).to have_content("Approved")
        expect(page).to_not have_button("Approve Pet")
      end

      within "#pet-#{pet2.id}-application" do
        expect(page).to_not have_content("Approved")
        expect(page).to have_button("Approve Pet")
      end

    end
  end
end
