require 'rails_helper'

describe 'As a visitor' do
  describe "When I visit '/shelters/:id' " do
    it "should display the shelter's id and information" do
      shelter1 = Shelter.create(name: 'Dogs and Cats',
                                address: '1234 spoon.st',
                                city: 'Tampa',
                                state: 'Florida',
                                zip: '34638')

      visit "/shelters/#{shelter1.id}"

      expect(page).to have_content(shelter1.id.to_s)
      expect(page).to have_content(shelter1.name.to_s)
      expect(page).to have_content(shelter1.address.to_s)
      expect(page).to have_content(shelter1.city.to_s)
      expect(page).to have_content(shelter1.state.to_s)
      expect(page).to have_content(shelter1.zip.to_s)
    end
  end
end

# Then I am taken to '/shelters/:id/edit' where I  see a form to edit the shelter's data including:
# - name
# - address
# - city
# - state
# - zip
# When I fill out the form with updated information
# And I click the button to submit the form
# Then a `PATCH` request is sent to '/shelters/:id',
# the shelter's info is updated,
# and I am redirected to the Shelter's Show page where I see the shelter's updated info

describe 'As a visitor' do
  describe 'When I visit a shelter show page' do
    it "should see a link 'Update shelter'" do
      shelter1 = Shelter.create(name: 'Dogs and Cats',
                                address: '1234 spoon.st',
                                city: 'Tampa',
                                state: 'Florida',
                                zip: '34638')

      visit "/shelters/#{shelter1.id}"
      click_link 'Update Shelter'

      expect(current_path).to eq("/shelters/#{shelter1.id}/edit")
    end
  end
end
