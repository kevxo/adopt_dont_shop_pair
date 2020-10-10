require 'rails_helper'

describe 'As a visitor' do
  describe 'When I visit the Shelter Index Page' do
    it "should see link create a new shelter, 'New Shelter'" do
      visit '/shelters'

      expect(page).to have_link('New Shelter')

      visit '/shelters'
      click_link 'New Shelter'

      expect(current_path).to eq('/shelters/new')
    end
  end
end

describe 'As a visitor' do
  describe "When I visit '/shelters' " do
    it 'Then I see the name of each shelter in the system' do
      shelter1 = Shelter.create(name: 'Dogs and Cats',
                                address: '1234 spoon.st',
                                city: 'Tampa',
                                state: 'Florida',
                                zip: '34638')
      shelter2 = Shelter.create(name: 'Pets are Us',
                                address: '1894 Lincoln.st',
                                city: 'Tampa',
                                state: 'Florida',
                                zip: '32938')
      visit '/shelters'

      expect(page).to have_content('All Shelters')
      expect(page).to have_content(shelter1.name.to_s)
      expect(page).to have_content(shelter2.name.to_s)
      expect(page).to have_content(shelter1.address.to_s)
      expect(page).to have_content(shelter2.address.to_s)
      expect(page).to have_content(shelter1.city.to_s)
      expect(page).to have_content(shelter2.city.to_s)
      expect(page).to have_content(shelter1.state.to_s)
      expect(page).to have_content(shelter2.state.to_s)
      expect(page).to have_content(shelter1.zip.to_s)
      expect(page).to have_content(shelter2.zip.to_s)
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
      pet1 = Pet.create(image: 'https://upload.wikimedia.org/wikipedia/commons/a/a3/June_odd-eyed-cat.jpg',
                        name: 'Mittens',
                        approximate_age: '6 years',
                        sex: 'Male',
                        shelters_id: shelter1.id)

      visit "/shelters/#{pet1.id}/pets"

      expect(page).to have_content("All Pets")
      expect(page).to have_xpath("//img[contains(@src,'#{pet1.image}')]")
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
      pet1 = Pet.create(image: 'https://upload.wikimedia.org/wikipedia/commons/a/a3/June_odd-eyed-cat.jpg',
                        name: 'Mittens',
                        approximate_age: '6 years',
                        sex: 'Male',
                        shelters_id: shelter1.id)

      visit "/shelters/#{pet1.id}/pets"

      expect(page).to have_link('Create Pet')

      visit "/shelters/#{pet1.id}/pets"
      click_link 'Create Pet'

      expect(current_path).to eq("/shelters/#{shelter1.id}/pets/new")
    end
  end
end
