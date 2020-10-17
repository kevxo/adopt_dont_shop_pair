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
  describe 'when I visit the shelter index page' do
    it 'should have a link where I can click and be directed to
    where I can edit the shelter' do
      shelter1 = Shelter.create(name: 'Dogs and Cats',
                                address: '1234 spoon.st',
                                city: 'Tampa',
                                state: 'Florida',
                                zip: '34638')
      visit '/shelters'

      within "#shelter-#{shelter1.id}" do
        expect(page).to have_link('Edit')
        click_link 'Edit'
      end
      expect(current_path).to eq("/shelters/#{shelter1.id}/edit")
    end
  end
end

describe 'As a visitor' do
  describe 'When I visit the shelter Index page' do
    it 'should see a link to delete that shelter and when I click Im
    returned to the shelter index page' do
      shelter1 = Shelter.create(name: 'Dogs and Cats',
                                address: '1234 spoon.st',
                                city: 'Tampa',
                                state: 'Florida',
                                zip: '34638')
      visit '/shelters'

      within "#shelter-#{shelter1.id}" do
        expect(page).to have_button('Delete')
        click_button 'Delete'
      end

      expect(current_path).to eq('/shelters')
    end
  end
end

describe 'As a visitor' do
  describe 'When I click on the name of a shelter anywhere on the sit' do
    it 'should take me to its show page' do
      shelter1 = Shelter.create(name: 'Dogs and Cats',
                                address: '1234 spoon.st',
                                city: 'Tampa',
                                state: 'Florida',
                                zip: '34638')
      visit '/shelters'

      expect(page).to have_link("#{shelter1.name}")

      visit '/shelters'
      click_link "#{shelter1.name}"

      expect(current_path).to eq("/shelters/#{shelter1.id}")
    end
  end
end

describe 'As a visitor' do
  describe 'When I visit any page on the site' do
    it 'should see a link that takes me to the Pet Index page' do
      visit '/shelters'

      expect(page).to have_link('Pet Index')

      visit '/shelters'

      click_link 'Pet Index'

      expect(current_path).to eq('/pets')
    end
  end
end
