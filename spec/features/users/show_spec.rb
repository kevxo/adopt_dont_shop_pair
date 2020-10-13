require 'rails_helper'

describe 'As a visitor' do
  describe "when I visit a User's show page" do
    it "should have all of the User's information" do
      user = User.create!(name: 'Bob',
                          street_address: '1234 Test Dr',
                          city: 'Denver',
                          state: 'Colorado',
                          zip: '12345')
      visit "/users/#{user.id}"

      expect(page).to have_content(user.name)
      expect(page).to have_content(user.street_address)
      expect(page).to have_content(user.city)
      expect(page).to have_content(user.state)
      expect(page).to have_content(user.zip)
    end
  end
end
