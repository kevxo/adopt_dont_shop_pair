require 'rails_helper'

RSpec.describe "As a user" do
  describe "when I visit a review edit page" do
    it "I cannot update a review with a missing title, content, and/or rating" do
      shelter1 = Shelter.create(name: 'Dogs and Cats',
                                address: '1234 spoon.st',
                                city: 'Tampa',
                                state: 'Florida',
                                zip: '34638')
      user = User.create!(name: 'Bob',
                          street_address: '1234 Test Dr',
                          city: 'Denver',
                          state: 'Colorado',
                          zip: '12345')
      review_1 = shelter1.reviews.new(title: "Colorado Cares is the best", rating: 5,
                content: "I absolutely love this shelter. I have found the best friends a man could have!",
                user_name: user.name)
      review_1.user_id = user.id
      review_1.save!

      visit "/shelters/#{shelter1.id}/reviews/#{review_1.id}/edit"

      fill_in :content, with: ''
      fill_in :user_name, with: user.name
      click_on("update review")

      expect(page).to have_content('Review not updated: Need title, content, and rating.')
      expect(page).to have_button('update review')

      fill_in :title, with: ''
      fill_in :user_name, with: user.name
      click_on("update review")

      expect(page).to have_content('Review not updated: Need title, content, and rating.')
      expect(page).to have_button('update review')

      fill_in :rating, with: ''
      fill_in :user_name, with: user.name
      click_on("update review")

      expect(page).to have_content('Review not updated: Need title, content, and rating.')
      expect(page).to have_button('update review')
    end

    it "I cannot update a review without a user that exists in the database" do
      shelter1 = Shelter.create(name: 'Dogs and Cats',
                                address: '1234 spoon.st',
                                city: 'Tampa',
                                state: 'Florida',
                                zip: '34638')
      user = User.create!(name: 'Bob',
                          street_address: '1234 Test Dr',
                          city: 'Denver',
                          state: 'Colorado',
                          zip: '12345')
      review_1 = shelter1.reviews.new(title: "Colorado Cares is the best", rating: 5,
                content: "I absolutely love this shelter. I have found the best friends a man could have!",
                user_name: user.name)
      review_1.user_id = user.id
      review_1.save!

      visit "/shelters/#{shelter1.id}/reviews/#{review_1.id}/edit"

      fill_in :user_name, with: "Jeffrey"
      click_on("update review")

      expect(page).to have_content("Review not updated: User doesn't exist in database.")
    end
  end
end
