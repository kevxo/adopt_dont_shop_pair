require 'rails_helper'

RSpec.describe "As a user" do
  describe "when I visit '/users/new'" do
    it "I can create a user with my name, street address, city, state, zip" do

      visit "/users/new"

      expect(page).to have_content("Name")
      expect(find_field("name").value).to eq(nil)
      expect(page).to have_content("Street address")
      expect(find_field("street_address").value).to eq(nil)
      expect(page).to have_content("City")
      expect(find_field("city").value).to eq(nil)
      expect(page).to have_content("State")
      expect(find_field("state").value).to eq(nil)
      expect(page).to have_content("Zip")
      expect(find_field("zip").value).to eq(nil)
      expect(page).to have_button("Create User")

      fill_in "name", with: "Jeffery Hamilton"
      fill_in "address", with: "1234 west first street"
      fill_in "city", with: "Denver"
      fill_in "state", with: "Colorado"
      fill_in "zip", with: "80029"

      click_on("Create User")

      new_user = User.last

      expect(current_path).to eq("/users/#{new_user.id}")

      expect(page).to have_content("Jeffery Hamilton")
      expect(page).to have_content("1234 west first street")
      expect(page).to have_content("Denver")
      expect(page).to have_content("Colorado")
      expect(page).to have_content("80029")

    end
  end
end
