require 'rails_helper'

describe 'As a visitor' do
  describe "when I visit '/pets/:id'" do
    it 'should see the pet with that id including pets information' do
      shelter1 = Shelter.create(name: 'Dogs and Cats',
                                address: '1234 spoon.st',
                                city: 'Tampa',
                                state: 'Florida',
                                zip: '34638')
      pet1 = Pet.create(img: 'https://upload.wikimedia.org/wikipedia/commons/a/a3/June_odd-eyed-cat.jpg',
                        name: 'Mittens',
                        description: "He's healthy",
                        approximate_age: '6 years',
                        sex: 'Male',
                        adoptable: 'Yes',
                        shelter_id: shelter1.id)

      visit "pets/#{pet1.id}"
      expect(page).to have_content(pet1.id)
      expect(page).to have_xpath("//img[contains(@src,'#{pet1.img}')]")
      expect(page).to have_content(pet1.name)
      expect(page).to have_content(pet1.description)
      expect(page).to have_content(pet1.approximate_age)
      expect(page).to have_content(pet1.sex)
      expect(page).to have_content(pet1.adoptable)
    end
  end
end

describe 'As a visitor' do
  describe 'when I visit Pet Show page' do
    it "should see a link to update Pet 'Update Pet'" do
      shelter1 = Shelter.create(name: 'Dogs and Cats',
                                address: '1234 spoon.st',
                                city: 'Tampa',
                                state: 'Florida',
                                zip: '34638')
      pet1 = Pet.create(img: 'https://upload.wikimedia.org/wikipedia/commons/a/a3/June_odd-eyed-cat.jpg',
                        name: 'Mittens',
                        description: "He's healthy",
                        approximate_age: '6 years',
                        sex: 'Male',
                        adoptable: 'Yes',
                        shelter_id: shelter1.id)

      visit "/pets/#{pet1.id}"
      expect(page).to have_link('Update Pet')

      visit "/pets/#{pet1.id}"
      click_link 'Update Pet'

      expect(current_path).to eq("/pets/#{pet1.id}/edit")
    end
  end
end

describe 'As a visitor' do
  describe 'When I visit a pet show page' do
    it "should see a link to delete a pet 'Delete Pet'" do
      shelter1 = Shelter.create(name: 'Dogs and Cats',
                                address: '1234 spoon.st',
                                city: 'Tampa',
                                state: 'Florida',
                                zip: '34638')
      pet1 = Pet.create(img: 'https://upload.wikimedia.org/wikipedia/commons/a/a3/June_odd-eyed-cat.jpg',
                        name: 'Mittens',
                        description: "He's healthy",
                        approximate_age: '6 years',
                        sex: 'Male',
                        adoptable: 'Yes',
                        shelter_id: shelter1.id)

      visit "/pets/#{pet1.id}"
      expect(page).to have_button('Delete Pet')
    end
  end
end
