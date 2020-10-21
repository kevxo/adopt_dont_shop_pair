require 'rails_helper'

RSpec.describe "As a user", type: :feature do
  describe "when I visit the '/shelters/:shelter_id' page" do
    describe "When I have clicked the button 'New Shelter' " do
      describe 'I can the form to fill out' do
        it 'should fill out the form for the new shelter and click
        create shelter and be redirected back to shelters' do
          visit '/shelters/new'

          fill_in 'name', with: 'Dog and Cats'
          fill_in 'address', with: '1234 spoon.st'
          fill_in 'city', with: 'Tampa'
          fill_in 'state', with: 'Florida'
          fill_in 'zip', with: '34638'

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

    describe "When I click 'New Review'" do
      it 'should take me to a page where I need to enter review info' do
        shelter1 = Shelter.create!(name: 'Dogs and Cats',
                                   address: '1234 spoon.st',
                                   city: 'Tampa',
                                   state: 'Florida',
                                   zip: '34638')
        user1 = User.create!(name: 'Bob',
                             street_address: '1234 Test Dr',
                             city: 'Denver',
                             state: 'Colorado',
                             zip: '12345')
        review1 = Review.create!(title: 'My Rating',
                                 rating: 3,
                                 content: 'The place is not bad.',
                                 picture: 'https://upload.wikimedia.org/wikipedia/commons/6/6a/Bob_Gibson_crop.JPG',
                                 shelter_id: shelter1.id,
                                 user_id: user1.id,
                                 user_name: user1.name)
        visit "/shelters/#{shelter1.id}/reviews/new"

        fill_in 'title',	with: 'My Opinion'
        fill_in 'user_name',	with: user1.name
        fill_in 'rating',	with: 4
        fill_in 'content',	with: 'The place is great. Customer service is awesome.'
        fill_in 'picture',	with: 'https://upload.wikimedia.org/wikipedia/commons/6/6a/Bob_Gibson_crop.JPG'

        click_button 'Submit Review'

        review = Review.last

        within("#review-#{review.id}") do
          expect(page).to have_content('My Opinion')
          expect(page).to_not have_content(review1.title)
          expect(page).to_not have_content(review1.content)
          expect(page).to have_content(user1.name)
          expect(page).to have_content(4)
          expect(page).to have_content('The place is great. Customer service is awesome.')
          expect(page).to have_xpath("//img[contains(@src,'https://upload.wikimedia.org/wikipedia/commons/6/6a/Bob_Gibson_crop.JPG')]")
          expect(current_path).to eq("/shelters/#{shelter1.id}")
        end
      end

      it 'I can not create a review without title, rating, and content' do
        shelter1 = Shelter.create!(name: 'Dogs and Cats',
                                   address: '1234 spoon.st',
                                   city: 'Tampa',
                                   state: 'Florida',
                                   zip: '34638')
        user1 = User.create!(name: 'Bob',
                             street_address: '1234 Test Dr',
                             city: 'Denver',
                             state: 'Colorado',
                             zip: '12345')
        title = 'My Rating'
        rating = 3
        content = 'The place is not bad.'
        picture = 'https://upload.wikimedia.org/wikipedia/commons/6/6a/Bob_Gibson_crop.JPG'
        shelter_id = shelter1.id
        user_id = user1.id
        user_name = user1.name
        visit "/shelters/#{shelter1.id}/reviews/new"
        fill_in 'user_name',	with: user1.name
        fill_in 'content',	with: content
        fill_in 'picture',	with: picture


        click_button 'Submit Review'

        expect(page).to have_content("Review not created: Need title, content, and rating.")
        expect(page).to have_button('Submit Review')
      end

      it "I cannot create a review without a valid username" do
        shelter1 = Shelter.create!(name: 'Dogs and Cats',
                                   address: '1234 spoon.st',
                                   city: 'Tampa',
                                   state: 'Florida',
                                   zip: '34638')
        user1 = User.create!(name: 'Bob',
                             street_address: '1234 Test Dr',
                             city: 'Denver',
                             state: 'Colorado',
                             zip: '12345')

        visit "/shelters/#{shelter1.id}/reviews/new"

        fill_in 'title',	with: 'My Opinion'
        fill_in 'user_name',	with: 'bob'
        fill_in 'rating',	with: 4
        fill_in 'content',	with: 'The place is great. Customer service is awesome.'
        fill_in 'picture',	with: 'https://upload.wikimedia.org/wikipedia/commons/6/6a/Bob_Gibson_crop.JPG'

        click_button("Submit Review")

        expect(page).to have_content("Review not created: User couldn't be found.")
        expect(find_field('picture').value).to eq(nil)
        expect(find_field('title').value).to eq(nil)
        expect(find_field('user_name').value).to eq(nil)
        expect(find_field('rating').value).to eq(nil)
        expect(find_field('content').value).to eq(nil)
        expect(page).to have_button("Submit Review")

      end

    end
  end
end
