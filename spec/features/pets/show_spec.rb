require 'rails_helper'

describe 'As a visitor' do
  describe "when I visit '/pets/:id'" do
    it 'should see the pet with that id including pets information' do
      pet1 = Pet.create(image: 'https://upload.wikimedia.org/wikipedia/commons/a/a3/June_odd-eyed-cat.jpg',
                        name: 'Mittens',
                        description: "He's healthy",
                        approximate_age: '6 years',
                        sex: 'Male',
                        adoptable: 'Yes')

      visit "pets/#{pet1.id}"
      expect(page).to have_content(pet1.id)
      expect(page).to have_xpath("//img[contains(@src,'#{pet1.image}')]")
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
      pet1 = Pet.create(image: 'https://upload.wikimedia.org/wikipedia/commons/a/a3/June_odd-eyed-cat.jpg',
                        name: 'Mittens',
                        description: "He's healthy",
                        approximate_age: '6 years',
                        sex: 'Male',
                        adoptable: 'Yes')

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
      pet1 = Pet.create(image: 'https://upload.wikimedia.org/wikipedia/commons/a/a3/June_odd-eyed-cat.jpg',
                        name: 'Mittens',
                        description: "He's healthy",
                        approximate_age: '6 years',
                        sex: 'Male',
                        adoptable: 'Yes')

      visit "/pets/#{pet1.id}"
      expect(page).to have_button('Delete Pet')
    end
  end
end