require 'rails_helper'

describe 'As a visitor' do
  describe "When I visit '/shelters' " do
    it 'Then I see the name of each shelter in the system' do
      shelter_1 = Shelter.create(name: 'Dogs and Cats',
                                 address: '1234 spoon.st',
                                 city: 'Tampa',
                                 state: 'Florida',
                                 zip: '34638')
      shelter_2 = Shelter.create(name: 'Pets are Us',
                                  address: '1894 Lincoln.st',
                                  city: 'Tampa',
                                  state: 'Florida',
                                  zip: '32938')
      visit '/shelters'

      expect(page).to have_content("All Shelters")
      expect(page).to have_content("#{shelter_1.name}")
      expect(page).to have_content("#{shelter_2.name}")
      expect(page).to have_content("#{shelter_1.address}")
      expect(page).to have_content("#{shelter_2.address}")
      expect(page).to have_content("#{shelter_1.city}")
      expect(page).to have_content("#{shelter_2.city}")
      expect(page).to have_content("#{shelter_1.state}")
      expect(page).to have_content("#{shelter_2.state}")
      expect(page).to have_content("#{shelter_1.zip}")
      expect(page).to have_content("#{shelter_2.zip}")
    end
  end
end
