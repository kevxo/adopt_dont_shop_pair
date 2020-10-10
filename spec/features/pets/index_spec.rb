require 'rails_helper'

describe 'As a visitor' do
  describe "When I visit '/pets'" do
    it 'should display each Pet in the system' do
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

      pet2 = Pet.create(image: 'https://upload.wikimedia.org/wikipedia/commons/3/38/Adorable-animal-cat-20787.jpg',
                        name: 'Tiger',
                        approximate_age: '4 years',
                        sex: 'Male',
                        shelters_id: shelter1.id)

      visit '/pets'

      expect(page).to have_content('All Pets')
      expect(page).to have_xpath("//img[contains(@src,'#{pet1.image}')]")
      expect(page).to have_xpath("//img[contains(@src,'#{pet2.image}')]")
      expect(page).to have_content(pet1.name)
      expect(page).to have_content(pet2.name)
      expect(page).to have_content(pet1.approximate_age)
      expect(page).to have_content(pet2.approximate_age)
      expect(page).to have_content(pet1.sex)
      expect(page).to have_content(pet2.sex)
      expect(page).to have_content(pet1.shelters_id)
      expect(page).to have_content(pet2.shelters_id)
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
