require 'rails_helper'

describe "When I have clicked the button 'New Shelter' " do
  describe 'User can the form to fill out' do
    it 'should fill out the form for the new shelter and click
    create shelter and be redirected back to shelters' do
      visit '/shelters/new'

      fill_in 'shelter[name]', with: 'Dog and Cats'
      fill_in 'shelter[address]', with: '1234 spoon.st'
      fill_in 'shelter[city]', with: 'Tampa'
      fill_in 'shelter[state]', with: 'Florida'
      fill_in 'shelter[zip]', with: '34638'

      click_button 'Create Shelter'
      expect(page).to have_content('Dog and Cats')
      expect(page).to have_content('1234 spoon.st')
      expect(page).to have_content('Tampa')
      expect(page).to have_content('Florida')
      expect(page).to have_content('34638')
      expect(current_path).to eq('/shelters')
    end
  end
end
