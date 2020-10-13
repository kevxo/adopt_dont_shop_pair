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

    it "should have all the reviews a user has written" do
      shelter_1 = Shelter.create!(name: "Colorado Cares", address: "867 magnolia st",
                               city: "Lakewood", state: "CO", zip: "80022")
      shelter_2 = Shelter.create!(name: "Mile High Shelters", address: "4534 north ave",
                               city: "Aurora", state: "Colorado", zip: "80123")
      user = User.create!(name: 'Bob Woodword',
                          street_address: '1234 Test Dr',
                          city: 'Denver',
                          state: 'Colorado',
                          zip: '12345')

      user_2  = User.create!(name: 'Jeff Daniels',
                          street_address: '455 west dr',
                          city: 'Denver',
                          state: 'Colorado',
                          zip: '87709')

      user_3 = User.create!(name: 'Holly Baker',
                          street_address: '4443 fountain ave',
                          city: 'Lakewood',
                          state: 'CO',
                          zip: '80009')

      review_1 = shelter_1.reviews.new(title: "Colorado Cares is the best", rating: 5,
                content: "I absolutely love this shelter. I have found the best friends a man could have!",
                name: "Bob")
      review_1.user_id = user.id
      review_1.save!

      review_2 = shelter_2.reviews.new(title: "Mile High, more like Mile bye", rating: 1,
                content: "All I can say is nope", name: "Bob")
      review_2.user_id = user.id
      review_2.save!

      review_3 = shelter_2.reviews.new(title: "Mile High, not my style", rating: 3,
                content: "Too many dalmations!", name: "Jeff")
      review_3.user_id = user_2.id
      review_3.save!

      visit "/users/#{user.id}"

      expect(page).to_not have_content(review_3.title)
      expect(page).to_not have_content(review_3.content)

      within ("#review-#{review_1.id}") do
        expect(page).to have_content(review_1.title)
        expect(page).to have_content(review_1.rating)
        expect(page).to have_content(review_1.content)
        expect(page).to_not have_content(review_2.title)
        expect(page).to_not have_content(review_2.rating)
        expect(page).to_not have_content(review_2.content)
      end

      within ("#review-#{review_2.id}") do
        expect(page).to have_content(review_2.title)
        expect(page).to have_content(review_2.rating)
        expect(page).to have_content(review_2.content)
        expect(page).to_not have_content(review_1.title)
        expect(page).to_not have_content(review_1.rating)
        expect(page).to_not have_content(review_1.content)
      end

      visit "/users/#{user_2.id}"

      expect(page).to_not have_content(review_1.title)
      expect(page).to_not have_content(review_1.content)
      expect(page).to_not have_content(review_2.title)
      expect(page).to_not have_content(review_2.content)

      within ("#review-#{review_3.id}") do
        expect(page).to have_content(review_3.title)
        expect(page).to have_content(review_3.rating)
        expect(page).to have_content(review_3.content)
      end

      visit "/users/#{user_3.id}"

      expect(page).to_not have_content("Rating: ")
    end

  end
end
