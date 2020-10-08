require 'rails_helper'

describe "After I see the 'Delete Shelter link'" do
  describe 'Then when I click' do
    it 'should send a delete request to delete the shelter and
    redirect me to shelter index page' do
      shelter1 = Shelter.create(name: 'Dogs and Cats',
                                address: '1234 spoon.st',
                                city: 'Tampa',
                                state: 'Florida',
                                zip: '34638')

      visit "/shelters/#{shelter1.id}"

      click_button 'Delete Shelter'

      expect(current_path).to eq("/shelters")
    end
  end
end
