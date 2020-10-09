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
                        shelter_id: shelter1.id)

      pet2 = Pet.create(image: 'https://upload.wikimedia.org/wikipedia/commons/3/38/Adorable-animal-cat-20787.jpg',
                        name: 'Tiger',
                        approximate_age: '4 years',
                        sex: 'Male',
                        shelter_id: shelter1.id)

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
      expect(page).to have_content(pet1.shelter_id)
      expect(page).to have_content(pet2.shelter_id)
    end
  end
end
