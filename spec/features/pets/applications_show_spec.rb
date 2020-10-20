require 'rails_helper'

RSpec.describe "As a visitor", type: :feature do
  describe "when I visit a pets show page and click the link to view applications" do
    it "I can see a list of all the applicant names for the pet" do
      user_1 = User.create!(name: 'Bob Woodword',
                          street_address: '1234 Test Dr',
                          city: 'Denver',
                          state: 'Colorado',
                          zip: '12345')

      user_2  = User.create!(name: 'Jeff Daniels',
                          street_address: '455 west dr',
                          city: 'Denver',
                          state: 'Colorado',
                          zip: '87709')

      user_3 = User.create!(name: 'Holly Baker',
                          street_address: '4443 fountain ave',
                          city: 'Lakewood',
                          state: 'CO',
                          zip: '80009')

      shelter_1 = Shelter.create!(name: "Rocky Mountain High", address: "1234 fake st.", city: "Denver", state: "CO", zip: "45505")

      pet1 = Pet.create!(img: 'https://upload.wikimedia.org/wikipedia/commons/a/a3/June_odd-eyed-cat.jpg',
                         name: 'Mittens',
                         approximate_age: '6 years',
                         sex: 'Male',
                         shelter_id: shelter_1.id)

      application_1 = Application.create!(user_name: user_1.name, user_id: user_1.id, application_status: "Pending")
      application_2 = Application.create!(user_name: user_2.name, user_id: user_1.id, application_status: "Pending")
      application_3 = Application.create!(user_name: user_3.name, user_id: user_1.id, application_status: "Pending")

      pet_app_1 = PetApplication.create!(pet_id: pet1.id, application_id: application_1.id)
      pet_app_2 = PetApplication.create!(pet_id: pet1.id, application_id: application_2.id)
      pet_app_3 = PetApplication.create!(pet_id: pet1.id, application_id: application_3.id)

      visit "/pets/#{pet1.id}"

      within "#view-applications" do
        click_link "View All Applications For This Pet"
      end

      expect(current_path).to eq("/pets/#{pet1.id}/applications")

      within ".pet-applicants" do
        expect(page).to have_content(application_1.user_name)
        expect(page).to have_content(application_2.user_name)
        expect(page).to have_content(application_3.user_name)
      end

      within "#applicant-#{application_1.id}" do
        click_on(application_1.user_name)
      end

      expect(current_path).to eq("/applications/#{application_1.id}")

      within ".application_info" do
        expect(page).to have_content(user_1.name)
        expect(page).to have_content(user_1.street_address)
        expect(page).to_not have_content(user_2.name)
        expect(page).to_not have_content(user_3.name)
      end

      within "#application-pets" do
        expect(page).to have_content(pet1.name)
      end
    end

    
  end
end
