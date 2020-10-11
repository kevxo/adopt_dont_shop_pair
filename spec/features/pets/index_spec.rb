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
      click_link 'Edit Pet'

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
      click_button 'Delete Pet'

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
end
