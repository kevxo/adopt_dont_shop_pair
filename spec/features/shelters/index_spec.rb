require 'rails_helper'

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
